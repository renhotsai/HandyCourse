//
//  WelcomeScreenView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/8/24.
//

import SwiftUI

struct WelcomeScreenView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BgColor").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
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
                    NavigationLink(
                        destination: LoginView(),
                        label: {
                            Text("Login")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0.0, y: 16)
                                .padding(.vertical)
                        }
                    )
                        
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
}

#Preview {
    WelcomeScreenView()
}
