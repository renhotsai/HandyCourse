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
    @EnvironmentObject var fireStorageHelper :FireStorageHelper
    
    @Environment(\.dismiss) var dismiss
    @State private var profileImage : UIImage?
    @State private var newName = ""
    @State private var newUsername = ""
    @State private var newEmail = ""
    @State private var newAddress = ""
    @State private var newPhoneNumber = ""
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @State private var showSheet: Bool = false
    @State private var permissionGranted: Bool = false
    @State private var showPicker : Bool = false
    @State private var isUsingCamera : Bool = false
    
   
    var body: some View {
        VStack(alignment: .leading) {
            Text("Edit Profile")
                .font(.title)
                .bold()
                .padding(.bottom, 20)
            
            Image(uiImage: profileImage ?? UIImage(systemName: "person")!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .padding(.bottom, 10)
                .padding(.top, 40)
                .padding(.leading, 30)
                .onAppear{
                    fireStorageHelper.getImageFromFirebaseStorage(imageName: fireDBHelper.user.name){ image in
                        if let image = image {
                            print("Image loaded successfully")
                            profileImage = image
                        } else {
                            print("Failed to load image")
                        }
                    }
                }
                .onTapGesture {
                    // Handle tap event here
                    print("Image tapped")
                    if (self.permissionGranted){
                        self.showSheet = true
                    }else{
                        checkPermission()
                    }
                    checkPermission()
                }.actionSheet(isPresented: self.$showSheet){
                    ActionSheet(title: Text("Select Photo"),
                                message: Text("Choose profile picture to upload"),
                                buttons: [
                    .default(Text("Choose photo from library")){
                        //show library picture picker
                        
                        //check if the source is availabe
                        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else{
                            print(#function, "The PhotoLibrary isn't available")
                            return
                        }
                        self.isUsingCamera = false
                        self.showPicker = true
                        
                    },
                    .default(Text("Take a new pic from Camera")){
                        //open camera
                        guard UIImagePickerController.isSourceTypeAvailable(.camera) else{
                            print(#function, "The Camera isn't available")
                            return
                        }
                        self.isUsingCamera = true
                        self.showPicker = false
                    },
                  .cancel()
                 ])
                }
            
            // New Name Field
            Text("New Name")
                .font(.headline)
            TextField("New Name", text: $newName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
                .onAppear {
                    newName = fireDBHelper.user.name
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
            Button(action: self.updateUser) {
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
        .fullScreenCover(isPresented: self.$showPicker){
            if (isUsingCamera){
                //open camera Picker
                CameraPicker(selectedImage: self.$profileImage)
            }else{
                //open library picker
                LibraryPicker(selectedImage: self.$profileImage)
            }
        }
    }
    
    func updateUser(){
        // Update the user profile
        var user = fireDBHelper.user
        user.name = newName
        user.address = newAddress
        user.phoneNumber = newPhoneNumber
        if profileImage == nil{
            fireDBHelper.updateUser(user : user)
        }else{
            fireDBHelper.updateUserImage(user: user,image: profileImage,fireStorageHelper: fireStorageHelper)
        }
        // Show an alert message
        alertTitle = "Profile Updated"
        alertMessage = "Your profile has been successfully updated."
        showAlert = true
        dismiss()
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
