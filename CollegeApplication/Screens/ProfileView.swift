//
//  ProfileView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/12/24.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var user: User
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                // Profile Image
                Image("hyun-image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .padding(.bottom, 10)
                    .padding(.top, 40)
                    .padding(.leading, 30)
                    
                
                
                // Username
                HStack {
                    Text("Username: ")
                        .font(.headline)
                    Text(user.username)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                // Email
                HStack {
                    Text("Email: ")
                        .font(.headline)
                    Text(user.email)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                // Address
                HStack {
                    Text("Address: ")
                        .font(.headline)
                    Text(user.address)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                // Phone Number
                HStack {
                    Text("Phone Number: ")
                        .font(.headline)
                    Text(user.phoneNumber)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .navigationTitle("Let's learn!")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                   NavigationBarMenu()
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ProfileView()
}