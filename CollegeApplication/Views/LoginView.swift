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
//    @State private var currUser : User = User()

    
    @State private var isLogin : Bool = false
    
    @Binding var rootScreen : RootScreen
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
                fireAuthHelper.signIn(email: email, password: password,fireDBHelper: fireDBHelper)
                rootScreen = .Main

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
            Button(action: {
                rootScreen = .SignUp
            }, label: {
                Text("Register")
            })
        }.navigationBarBackButtonHidden(hideBackButton)
    }
    

}

#Preview {
    LoginView(rootScreen: .constant(.Login))
}
