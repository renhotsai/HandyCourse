//
//  SignInView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/8/24.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var confirmPassword : String = ""
    @State private var isStudent = true
    
    var body: some View {
        VStack{
            Form {
                TextField("Enter Email", text: self.$email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Enter Password", text: self.$password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Enter Password Again", text: self.$confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Toggle(isOn: $isStudent) {
                    Text("Student")
                }
            }.disableAutocorrection(true)
            
            Section{
                Button(action: {
                    //Task : validate the data
                    //such as all the inputs are not empty
                    //and check for password rule
                    //and display alert accordingly
                    
                    //if all the data is validated, create account on FirebaseAuth
                    self.fireAuthHelper.signUp(email: self.email, password: self.password)
                    
                    
                    var user : User
                    if isStudent {
                        user = Student(email: self.email)
                    } else {
                        user = Instructor(email: self.email)
                    }
                    self.fireDBHelper.insertUser(user : user)
                    //move to home screen
//                    self.rootScreen = .Home
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
    SignInView()
}
