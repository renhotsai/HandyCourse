//
//  SignInView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/8/24.
//

import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                VStack {
                    Text("Register")
                        .font(.largeTitle)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.top, 30)
                        .padding(.bottom, 30)
                    SocialLoginButton(image: Image("apple-logo"), text: Text("Sign in with Apple"))
                    SocialLoginButton(image: Image("google"), text: Text("Sign in with Google"))
                        .padding(.vertical)
                    
                    Text("or get a link emailed to you")
                        .foregroundColor(Color.black.opacity(0.4))
                    
                    TextField("Work email address", text: $email)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                        .padding(.vertical)
                    
                    Button("Email me a signup link") {
                        
                    }.font(.title3)
                        .padding()
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(50)
                } // VStack
                Spacer()
                Divider()
                Spacer()
                Text("You are completely safe.")
                Text("Read our Terms & conditions.")
                    .foregroundColor(Color.blue)
            }
            .padding()
        } // ZStack

    
    }
    
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
