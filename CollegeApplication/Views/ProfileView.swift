//
//  ProfileView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/12/24.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @EnvironmentObject var fireStorageHelper : FireStorageHelper
    @State private var profileImage : UIImage?
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                // Profile Image
                
                Image(uiImage:profileImage ?? UIImage(systemName: "person")!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .padding(.bottom, 10)
                        .padding(.top, 40)
                        .padding(.leading, 30)
                        
                
                
                // Name, Username, Email, Address, Phone Number
                HStack {
                    Text("Name: ").font(.headline)
                    Text(fireDBHelper.user.name).font(.subheadline).foregroundColor(.gray)
                }
                HStack {
                    Text("Address: ").font(.headline)
                    Text(fireDBHelper.user.address).font(.subheadline).foregroundColor(.gray)
                }
                HStack {
                    Text("Phone Number: ").font(.headline)
                    Text(fireDBHelper.user.phoneNumber).font(.subheadline).foregroundColor(.gray)
                }
                
                Spacer()
                
                // Edit Profile Button
                NavigationLink(destination: EditProfileView().environmentObject(fireDBHelper).environmentObject(fireStorageHelper)) {
                    Text("Edit Profile")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
            .onAppear{
                fireStorageHelper.getImageFromFirebaseStorage(imageName: fireDBHelper.user.name){ image in
                    if let image = image {
                        print("Image loaded successfully")
                        profileImage = image
                    } else {
                        print("Failed to load image")
                    }
                }
            }// Add padding to the VStack
        }
    }
}

