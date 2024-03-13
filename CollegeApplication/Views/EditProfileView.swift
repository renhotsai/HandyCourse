//
//  EditProfileView.swift
//  CollegeApplication
//
//  Created by Aman  Chahal on 2/15/24.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @EnvironmentObject var fireDBHelper :FireDBHelper
    @State private var newName = ""
    @State private var newUsername = ""
    @State private var newEmail = ""
    @State private var newAddress = ""
    @State private var newPhoneNumber = ""
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var permissionGranted: Bool = false
   
    var body: some View {
        VStack(alignment: .leading) {
            Text("Edit Profile")
                .font(.title)
                .bold()
                .padding(.bottom, 20)
            
            // New Name Field
            Text("New Name")
                .font(.headline)
            TextField("New Name", text: $newName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
                .onAppear {
                    newName = fireDBHelper.user.name
                }
            
            // New Username Field
            Text("New Username")
                .font(.headline)
            TextField("New Username", text: $newUsername)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
                .onAppear {
//                    newUsername = user.username
                }
            
            // New Email Field
            Text("New Email")
                .font(.headline)
            TextField("New Email", text: $newEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
                .onAppear {
                    newEmail = fireDBHelper.user.email
                }
            
            // New Address Field
            Text("New Address")
                .font(.headline)
            TextField("New Address", text: $newAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
                .onAppear {
                    newAddress = fireDBHelper.user.address
                }
            
            // New Phone Number Field
            Text("New Phone Number")
                .font(.headline)
            TextField("New Phone Number", text: $newPhoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 20)
                .onAppear {
                    newPhoneNumber = fireDBHelper.user.phoneNumber
                }
            
            // Submission Button
            Button(action: {
                // Update the user profile
                fireDBHelper.user.name = newName
//                user.username = newUsername
                fireDBHelper.user.email = newEmail
                fireDBHelper.user.address = newAddress
                fireDBHelper.user.phoneNumber = newPhoneNumber
                
                // Send an object will change notification
                //fireDBHelper.user.objectWillChange.send()
                
                // Show an alert message
                alertTitle = "Profile Updated"
                alertMessage = "Your profile has been successfully updated."
                showAlert = true
            }) {
                Text("Submit")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func checkPermission(){
        switch PHPhotoLibrary.authorizationStatus(){
        case .authorized:
            self.permissionGranted = true
        case.notDetermined, .denied:
            self.requestPermission()
        case.limited,.restricted: break
            //inform the user abouut possibly granting full access
            
        @unknown default:
            return
        }
    }
    
    func requestPermission(){
        PHPhotoLibrary.requestAuthorization{ status in
            switch status {
            case .authorized:
                self.permissionGranted = true
            case.notDetermined, .denied:
                self.permissionGranted = false
            case.limited,.restricted: break
                //inform the user abouut possibly granting full access
                
            @unknown default:
                return
            }
        }
    }
}

#Preview {
    EditProfileView()
}
