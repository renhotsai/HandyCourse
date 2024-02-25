//
//  PasswordResetView.swift
//  CollegeApplication
//
//  Created by Aman  Chahal on 2/15/24.
//

import SwiftUI


struct PasswordResetView: View {
    @EnvironmentObject var user: User
    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var confirmedPassword = ""
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Reset Password")
                .font(.title)
                .bold()
                .padding(.bottom, 20)
            
            // Test Field for Current Password
            Text("Current Password")
                .font(.headline)
            SecureField("Current Password", text: $currentPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
                .textContentType(.password)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            // Test Field for New Password
            Text("New Password (Lowercase Only)")
                .font(.headline)
            SecureField("New Password", text: $newPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
                .textContentType(.newPassword)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .onChange(of: newPassword) { newValue in
                    // Convert the entered password to lowercase
                    newPassword = newValue.lowercased()
                }
            
            // Test Field for Confirmed Password
            Text("Confirm New Password")
                .font(.headline)
            SecureField("Confirm New Password", text: $confirmedPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 20)
                .textContentType(.newPassword)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            // Submission Button
            Button(action: {
                // Your submission logic goes here
                if currentPassword != user.password {
                    alertTitle = "Current Password Incorrect"
                    alertMessage = "Please enter the correct current password."
                } else if newPassword.isEmpty || confirmedPassword.isEmpty {
                    alertTitle = "Empty Fields"
                    alertMessage = "Please fill in all fields."
                } else if newPassword != confirmedPassword {
                    alertTitle = "Passwords Don't Match"
                    alertMessage = "The new passwords entered do not match."
                } else {
                    // Password reset successful
                    user.password = newPassword
                    alertTitle = "Password Reset Successful"
                    alertMessage = "Your password has been successfully reset."
                }
                
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
}

#Preview {
    PasswordResetView()
}
