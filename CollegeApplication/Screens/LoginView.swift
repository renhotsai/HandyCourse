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
    @State private var wrongUsername: Int = 0
    @State private var wrongPassword: Int = 0
    @State private var showingLoginScreen: Bool = false
    
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
                        .border(.red, width: CGFloat(wrongUsername))
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                
                   

                    Button("Login") {
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
                        .foregroundStyle(Color.red)
                    
                }
            }
        }.navigationBarHidden(true)
    }
    
    func authenticateUser(username: String, password: String) {
        
        if username.isEmpty {
            wrongUsername = 2
            self.errorMessage = "Empty Username"
            return
        } else if password.isEmpty {
            wrongPassword = 2
            self.errorMessage = "Empty Password"
            return
        }
        
        guard let user = users.first(where: {$0.username == username.lowercased()}) else{
            wrongUsername = 2
            self.errorMessage = "Wrong Username"
            return
        }
        
        guard password.lowercased() == user.password  else {
            wrongPassword = 2
            self.errorMessage = "Wrong Password"
            return
        }
        
        
        self.errorMessage = ""
        wrongUsername = 0
        wrongPassword = 0
        showingLoginScreen = true
    }
}
//Instructor(name: "Jeremy", username: "jeremy", password: "jeremy"),
//Instructor(name: "Hyun", username: "hyun", password: "hyun"),
//Instructor(name: "Aman", username: "aman", password: "aman"),
//Student(name: "Jack", username: "jack", password: "jack"),
//Student(name: "Mike", username: "mike", password: "mike"),
//Student(name: "Amy", username: "amy", password: "amy")
#Preview {
    LoginView()
}
