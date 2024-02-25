//
//  ContactView.swift
//  CollegeApplication
//
//  Created by Aman  Chahal on 2/15/24.
//

import SwiftUI

struct ContactView: View {
    @State private var name: String = ""
    @State private var subject: String = ""
    @State private var contactNumber: String = ""
    @State private var email: String = ""
    @State private var message: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    let maxMessageLength = 1000
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Group {
                ContactTextField(description: "Name", text: $name)
                ContactTextField(description: "Subject", text: $subject)
                ContactTextField(description: "Contact Number", text: $contactNumber)
                ContactTextField(description: "Email", text: $email)
            }
            .padding(.horizontal)
            
            Text("Message (Remaining \(maxMessageLength - message.count) characters)")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.horizontal)
            
            TextEditor(text: $message)
                .frame(minHeight: 100)
                .padding(.horizontal, 15) // Add horizontal padding
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .onChange(of: message) { newValue in
                    if newValue.count > maxMessageLength {
                        self.message = String(newValue.prefix(maxMessageLength))
                    }
                }
                .padding(.horizontal)
            
            Button(action: {
                self.submitForm()
            }, label: {
                Text("Submit")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            })
            .padding(.horizontal)
            
        }
        .padding(.vertical, 20)
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func submitForm() {
        if name.isEmpty || subject.isEmpty || email.isEmpty || contactNumber.isEmpty {
            self.alertMessage = "Please fill in all required fields."
            self.alertTitle = "Submission Failed"
            self.showAlert = true
        } else {
            // Create a dictionary to hold form data
            let formData: [String: Any] = [
                "Name": name,
                "Subject": subject,
                "Contact Number": contactNumber,
                "Email": email,
                "Message": message
            ]
            
            // Convert the dictionary to a JSON string and print for now later on could export this
            if let jsonData = try? JSONSerialization.data(withJSONObject: formData, options: .prettyPrinted) {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
            }
            
            // Show submission alert
            self.alertMessage = "Form submitted successfully!"
            self.alertTitle = "Submission Successful"
            self.showAlert = true
            
            // Reset fields after submission
            self.name = ""
            self.subject = ""
            self.contactNumber = ""
            self.email = ""
            self.message = ""
        }
    }
}

struct ContactTextField: View {
    var description: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(description)
                .font(.headline)
                .foregroundColor(.black)
            
            TextField("Enter \(description)", text: $text)
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
        }
    }
}

#Preview {
    ContactView()
}
