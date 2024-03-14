//
//  EditProfileView.swift
//  CollegeApplication
//
//  Created by Aman  Chahal on 2/15/24.
//

import SwiftUI
import PhotosUI
import CoreLocation

struct EditProfileView: View {
    @EnvironmentObject var fireDBHelper: FireDBHelper
    @EnvironmentObject var fireStorageHelper: FireStorageHelper
    @Environment(\.dismiss) var dismiss
    @State private var profileImage: UIImage?
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
    @State private var showPicker: Bool = false
    @State private var isUsingCamera: Bool = false
    @State private var currentLocationAddress: String = ""
    @StateObject private var locationHelper = LocationHelper()

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
                .onAppear {
                    fireStorageHelper.getImageFromFirebaseStorage(imageName: fireDBHelper.user.name) { image in
                        if let image = image {
                            print("Image loaded successfully")
                            profileImage = image
                        } else {
                            print("Failed to load image")
                        }
                    }
                }
                .onTapGesture {
                    if self.permissionGranted {
                        self.showSheet = true
                    } else {
                        checkPermission()
                    }
                    checkPermission()
                }
                .actionSheet(isPresented: self.$showSheet) {
                    ActionSheet(title: Text("Select Photo"),
                                message: Text("Choose profile picture to upload"),
                                buttons: [
                                    .default(Text("Choose photo from library")) {
                                        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                                            print("The PhotoLibrary isn't available")
                                            return
                                        }
                                        self.isUsingCamera = false
                                        self.showPicker = true
                                    },
                                    .default(Text("Take a new pic from Camera")) {
                                        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                                            print("The Camera isn't available")
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

            // location and address
            HStack {
                Text("New Address")
                    .font(.headline)
                
                Spacer()
                
                Image(systemName: "mappin.circle.fill")
                    .foregroundColor(.blue)
                    .font(.system(size: 25))
                    .onTapGesture {
                        fetchCurrentLocation()
                    }
            }
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
            
            // Submission btn
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
        .fullScreenCover(isPresented: self.$showPicker) {
            if isUsingCamera {
                CameraPicker(selectedImage: self.$profileImage)
            } else {
                LibraryPicker(selectedImage: self.$profileImage)
            }
        }
        .environmentObject(locationHelper)
    }

    func updateUser() {
        var user = fireDBHelper.user
        user.name = newName
        user.address = newAddress
        user.phoneNumber = newPhoneNumber
        if profileImage == nil {
            fireDBHelper.updateUser(user: user)
        } else {
            fireDBHelper.updateUserImage(user: user, image: profileImage, fireStorageHelper: fireStorageHelper)
        }
        alertTitle = "Profile Updated"
        alertMessage = "Your profile has been successfully updated."
        showAlert = true
        dismiss()
    }

    func checkPermission() {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            self.permissionGranted = true
        case .notDetermined, .denied:
            self.requestPermission()
        case .limited, .restricted: break
        @unknown default:
            return
        }
    }

    func requestPermission() {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                self.permissionGranted = true
            case .notDetermined, .denied:
                self.permissionGranted = false
            case .limited, .restricted: break
            @unknown default:
                return
            }
        }
    }

    func fetchCurrentLocation() {
        guard let location = locationHelper.currentLocation else {
            print("Location not available")
            return
        }

        locationHelper.doReverseGeocoding(location: location) { address, error in
            if let error = error {
                print("Error fetching address: \(error.localizedDescription)")
                return
            }

            if let address = address {
                DispatchQueue.main.async {
                    self.newAddress = address
                }
            }
        }
    }
}

#if DEBUG
struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
#endif
