//
//  LoginView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/8/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @State private var email: String = ""
    @State private var password: String = ""

    @State private var showingLoginScreen: Bool = false
    
    @State private var isUsernameError: Bool = false
    @State private var isPasswordError: Bool = false
    @State private var errorMessage: String = ""
    
//    @State private var currUser : User = User()

    
    @State private var isLogin : Bool = false
    
    var body: some View {
        
        VStack {
            Text("Login")
                .font(.largeTitle)
                .bold()
                .padding()
            
            TextField("Email", text: $email)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                .border(isUsernameError ? Color.red : Color.clear, width: 2)
            
            SecureField("Password", text: $password)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                .border(isPasswordError ? Color.red : Color.clear, width: 2)
            
            Button("Login") {
                isUsernameError = false
                isPasswordError = false
                fireAuthHelper.signIn(email: email, password: password)
//                authenticateUser(username: username, password: password)
            }.navigationDestination(isPresented: $isLogin, destination: {
                ContentView()
            })
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .background(Color.blue)
            .cornerRadius(10)
            
            Text(self.errorMessage)
                .foregroundColor(.red)
            
        }
    }
    
//    func authenticateUser(username: String, password: String) {
//   
//        if username.isEmpty {
//            isUsernameError = true
//            errorMessage = ErrorCode.EmptyUsername.localizedDescription
//            return
//        } else if password.isEmpty {
//            isPasswordError = true
//            errorMessage = ErrorCode.EmptyPassword.localizedDescription
//            return
//        }
//        
//        guard let user = users.first(where: { $0.username == username.lowercased() }) else {
//            print("Error1")
//            isUsernameError = true
//            errorMessage = ErrorCode.WrongUsername.localizedDescription
//            return
//        }
//        
//        guard password.lowercased() == user.password else {
//            print("Error2")
//            isPasswordError = true
//            errorMessage = ErrorCode.WrongPassword.localizedDescription
//            return
//        }
//        
//        // No errors
//        self.errorMessage = ""
//        showingLoginScreen = true
//        currUser = user
//                
//
//        self.isLogin = true
//    }
}

#Preview {
    LoginView()
}
