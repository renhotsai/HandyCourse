//
//  LoginView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/8/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @EnvironmentObject var fireDBHelper: FireDBHelper
    
    @State private var email: String = ""
    @State private var password: String = ""

    @State private var showingLoginScreen: Bool = false
    
    @State private var isUsernameError: Bool = false
    @State private var isPasswordError: Bool = false
    @State private var errorMessage: String = ""
    
    @State private var hideBackButton = true
    
    @State private var rememberMe = false
    
    @State private var isLogin : Bool = false
    

    
    @Binding var rootScreen : RootScreen
    
    var body: some View {
        let loginButtonBackgroundColor = Color(red: 79/255, green: 204/255, blue: 163/255)

        VStack {
            Image("handycourse-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 100)
                .padding()

            
            ZStack(alignment: .bottomLeading) {
                Rectangle()
                    .fill(isUsernameError ? Color.red : Color.gray)
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .frame(width: UIScreen.main.bounds.width / 1.3)

                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.gray)
                        
                    TextField("Email", text: $email)
                        .padding(.vertical)
                        .frame(height: 50)
                        .frame(width: UIScreen.main.bounds.width / 1.7)
                        .border(Color.clear, width: 1)
                }
                
            }

           

            ZStack(alignment: .bottomLeading) {
                Rectangle()
                    .fill(isPasswordError ? Color.red : Color.gray)
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .frame(width: UIScreen.main.bounds.width / 1.3)

                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.gray)
                    SecureField("Password", text: $password)
                        .padding(.vertical)
                        .frame(height: 50)
                        .frame(width: UIScreen.main.bounds.width / 1.7)
                        .border(Color.clear, width: 1)
                }
            }

         
            HStack {
                Button(action: {
                    rememberMe.toggle()
      
                }) {
                    ZStack {
                        Rectangle()
                            .stroke(Color.gray, lineWidth: 1)
                                .frame(width: 20, height: 20)
                        
                        if (rememberMe) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
                    
                Text("Remember me")
                    .foregroundColor(.gray)
                                
            }
            .padding(.top, 15)
            .padding(.bottom, 50)
            .padding(.trailing, 160)
    
            
            Button("Login") {
                isUsernameError = false
                isPasswordError = false
                
                if (rememberMe) {
                    UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(password, forKey: "password")
                } else {
                    UserDefaults.standard.removeObject(forKey: "email")
                    UserDefaults.standard.removeObject(forKey: "password")
                }
                
                fireAuthHelper.signIn(email: email, password: password)
                fireDBHelper.getUser(email: email)
                rootScreen = .Main
     
          
            }.navigationDestination(isPresented: $isLogin, destination: {
                ContentView()
            })
            .foregroundColor(.white)
            .frame(width:  UIScreen.main.bounds.width / 1.3, height: 50)
            .background(loginButtonBackgroundColor)
            .cornerRadius(15)
            
            Text(self.errorMessage)
                .foregroundColor(.red)
            
            HStack {
                Text("Don't have an account?")
                
                Button(action: {
                    rootScreen = .SignUp
                }) {
                    Text("Sign up")
                }
            }
        }.navigationBarBackButtonHidden(hideBackButton)
            .onAppear {
                let savedEmail = UserDefaults.standard.string(forKey: "email") ?? ""
                let savedPassword = UserDefaults.standard.string(forKey: "password") ?? ""
                
                if !savedEmail.isEmpty && !savedPassword.isEmpty {
                    fireAuthHelper.signIn(email: savedEmail, password: savedPassword)
                    fireDBHelper.getUser(email: savedEmail)
                    rootScreen = .Main
                }
              
            }
    }
    

}

#Preview {
    LoginView(rootScreen: .constant(.Login))
}
