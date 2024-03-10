//
//  FireAuthHelper.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/26.
//

import Foundation
import FirebaseAuth

class FireAuthHelper: ObservableObject{
    
    @Published var user : FirebaseAuth.User?{
        didSet{
            objectWillChange.send()
        }
    }
    
    func listenToAuthState(){
        Auth.auth().addStateDidChangeListener{ [weak self] _, user in
            guard let self = self else{
                //no change in the auth state
                return
            }
            
            //user's auth state has changed
            self.user = user
        }
    }
    
    func signUp(email : String, password : String, isStudent: Bool, fireDBHelper: FireDBHelper){
        
        Auth.auth().createUser(withEmail: email, password: password){ [self] authResult, error in
            
            guard let result = authResult else{
                print(#function, "Error while creating account : \(error!)")
                return
            }
            
            print(#function, "AuthResult : \(result)")
            
            switch authResult{
            case .none:
                print(#function, "Unable to create the account")
            case .some(_):
                print(#function, "Successfully created user account")
                self.user = authResult?.user
                
                UserDefaults.standard.set(self.user?.email, forKey: "KEY_EMAIL")
                UserDefaults.standard.set(password, forKey: "KEY_PASSWORD")
                var user : User
                
                if isStudent {
                    user = User(id:self.user!.uid, email: email, userRole: .Student)
                } else {
                    
                    user = User(id:self.user!.uid, email: email, userRole: .Instructor)
                }
                fireDBHelper.insertUser(user : user)
                
            }
        }
    }
    
    func signIn(email : String, password : String){
        
        Auth.auth().signIn(withEmail: email, password: password){ [self] authResult, error in
            
            guard let result = authResult else{
                print(#function, "Error while logging in : \(error!)")
                return
            }
            
            print(#function, "AuthResult : \(result)")
            
            switch authResult{
            case .none:
                print(#function, "Unable to sign in")
            case .some(_):
                print(#function, "Login Successful")
                self.user = authResult?.user
                
                print(#function, "Logged in user : \(self.user?.displayName ?? "NA" )")
      
                UserDefaults.standard.set(self.user?.email, forKey: "KEY_EMAIL")
                UserDefaults.standard.set(password, forKey: "KEY_PASSWORD")
            }
            
        }
        
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut()
            self.user = nil
        }catch let err as NSError{
            print(#function, "Unable to sign out the user : \(err)")
        }
    }
    
    func changePassword(){
        
    }
}
