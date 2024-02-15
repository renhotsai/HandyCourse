//
//  ProfileView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/12/24.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var user: User
    @State private var profileUUID = UUID()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                // Profile Image
                if let imageName = user.imageName {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .padding(.bottom, 10)
                        .padding(.top, 40)
                        .padding(.leading, 30)
                } else {
                    Image(systemName: "person")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .padding(.bottom, 10)
                        .padding(.top, 40)
                        .padding(.leading, 30)
                }
                
                // Name, Username, Email, Address, Phone Number
                HStack {
                    Text("Name: ").font(.headline)
                    Text(user.name).font(.subheadline).foregroundColor(.gray)
                }
                HStack {
                    Text("Username: ").font(.headline)
                    Text(user.username).font(.subheadline).foregroundColor(.gray)
                }
                HStack {
                    Text("Email: ").font(.headline)
                    Text(user.email).font(.subheadline).foregroundColor(.gray)
                }
                HStack {
                    Text("Address: ").font(.headline)
                    Text(user.address).font(.subheadline).foregroundColor(.gray)
                }
                HStack {
                    Text("Phone Number: ").font(.headline)
                    Text(user.phoneNumber).font(.subheadline).foregroundColor(.gray)
                }
                
                Spacer()
                
                // Edit Profile Button
                NavigationLink(destination: EditProfileView().environmentObject(user)) {
                    Text("Edit Profile")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .id(profileUUID) // Add a unique identifier to the NavigationLink
                
                // Reset Password Button
                NavigationLink(destination: PasswordResetView().environmentObject(user)) {
                    Text("Reset Password")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                
            }
            .padding() // Add padding to the VStack
            .onReceive(user.objectWillChange) { _ in
                // Reload the view when the user object changes
                self.profileUUID = UUID()
            }
        }
    }
}

#Preview {
    ProfileView().environmentObject(User())
}
