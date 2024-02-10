//
//  LoginView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/8/24.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""

    @State private var showingLoginScreen: Bool = false
    
    @State private var isUsernameError: Bool = false
    @State private var isPasswordError: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
                
                VStack {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    TextField("Username", text: $username)
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
                        authenticateUser(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .navigationDestination(
                        isPresented: $showingLoginScreen,
                        destination: {
                            CourseView()
                        }
                    )
                    
                    Text(self.errorMessage)
                        .foregroundColor(.red)
                    
                }
            }
        }.navigationBarHidden(true)
    }
    
    func authenticateUser(username: String, password: String) {
  
        
        if username.isEmpty {
            isUsernameError = true
            errorMessage = ErrorCode.EmptyUsername.localizedDescription
            return
        } else if password.isEmpty {
            isPasswordError = true
            errorMessage = ErrorCode.EmptyPassword.localizedDescription
            return
        }
        
        guard let user = users.first(where: { $0.username == username.lowercased() }) else {
            isUsernameError = true
            errorMessage = ErrorCode.WrongUsername.localizedDescription
            return
        }
        
        guard password.lowercased() == user.password else {
            isPasswordError = true
            errorMessage = ErrorCode.WrongPassword.localizedDescription
            return
        }
        
        // No errors
 
        showingLoginScreen = true
    }
}

#Preview {
    LoginView()
}
