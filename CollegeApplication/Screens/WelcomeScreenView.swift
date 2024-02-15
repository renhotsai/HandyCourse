//
//  WelcomeScreenView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/8/24.
//

import SwiftUI

struct WelcomeScreenView: View {
    @State private var pressLogin = false
    @State private var pressRegister = false
    
    //for login
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showingLoginScreen: Bool = false
    @State private var isUsernameError: Bool = false
    @State private var isPasswordError: Bool = false
    @State private var errorMessage: String = ""
    @State private var isLogin : Bool = false
    //for login
    
    @State private var currUser : User = User()
    
    
    var body: some View {
        
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            //ContentView
            if isLogin{
                ContentView().environmentObject(currUser)
            }
            
            //Login page
            else if pressLogin{
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
                    
                    Text(self.errorMessage)
                        .foregroundColor(.red)
                    
                }
            }
            
            //Register
            else if pressRegister{
                
            }
            
            
            //StartPage
            else {
                VStack {
                    Image("online_learning")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 350, height: 350)
                    
                    Button("Get Started") {
                        
                    }.font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(50)
                    
                    Button(action: {
                        self.pressLogin = true
                    }, label: {
                        Text("Login")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(50.0)
                            .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0.0, y: 16)
                            .padding(.vertical)
                    })
                    HStack {
                        Text("New around here?")
                        NavigationLink (
                            destination: SignInView(),
                            label: {
                                Text("Register")
                                    .foregroundColor(Color.blue)
                            }
                        )
                    }
                }
                .padding()
            }
        }
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
            print("Error1")
            isUsernameError = true
            errorMessage = ErrorCode.WrongUsername.localizedDescription
            return
        }
        
        guard password.lowercased() == user.password else {
            print("Error2")
            isPasswordError = true
            errorMessage = ErrorCode.WrongPassword.localizedDescription
            return
        }
        
        // No errors
        self.errorMessage = ""
        showingLoginScreen = true
        currUser = user
        self.isLogin = true
        self.pressLogin = false
    }
}
#Preview {
    WelcomeScreenView()
}
