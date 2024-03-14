//
//  SignInView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/8/24.
//

import SwiftUI

struct SignInView: View {
    @Binding var rootScreen : RootScreen
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var confirmPassword : String = ""
    @State private var username: String = ""
    
    @State private var isStudent = true
    @State private var errorMsg = ""
    
    var body: some View {
        VStack{
            Form {
                TextField("Enter Email", text: self.$email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Enter Password", text: self.$password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Enter Password Again", text: self.$confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Enter Full Name", text: self.$username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Toggle(isOn: $isStudent) {
                    Text("Student")
                }
                
                Text(errorMsg)
            }.disableAutocorrection(true)
            
            Section{
                Button(action: {
                    //Task : validate the data
                    //such as all the inputs are not empty
                    //and check for password rule
                    //and display alert accordingly
                    guard !email.isEmpty else{
                        self.errorMsg = "Email empty."
                        return
                    }
                    
                    guard !password.isEmpty else {
                        self.errorMsg = "Password empty."
                        return
                    }
                    
                    guard password == confirmPassword else{
                        self.errorMsg = "password is different."
                        return
                    }
                    
                    
                    //if all the data is validated, create account on FirebaseAuth
                    self.fireAuthHelper.signUp(email: self.email, password: self.password, isStudent: self.isStudent,fireDBHelper: fireDBHelper)
                    //move to home screen
                    if (fireAuthHelper.user != nil){
                        rootScreen = .Main
                    }
                }){
                    Text("Create Account")
                }//Button ends
                .disabled( self.password != self.confirmPassword && self.email.isEmpty && self.password.isEmpty && self.confirmPassword.isEmpty)
                
            }//Section ends
            
        }//VStack ends
        .navigationTitle("Registration")
        .navigationBarTitleDisplayMode(.inline)
    
    }//body ends
}

struct SocialLoginButton: View {
    var image: Image
    var text: Text
    
    var body: some View {
        HStack {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(.horizontal)
            Spacer()
            text
                .font(.title2)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(50.0)
        .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
    }
}
#Preview {
    SignInView(rootScreen: .constant(.SignUp))
}
