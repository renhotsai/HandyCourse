//
//  AddCourseContentView.swift
//  CollegeApplication
//
//  Created by 이현성 on 3/13/24.
//

import SwiftUI

struct AddCourseContentView: View {
    @EnvironmentObject var fireDBHelper: FireDBHelper
    @State private var contentTitle: String = ""
    @State private var videoURL: String = ""
    @State private var description: String = "" // New state for description
    @Environment(\.dismiss) private var dismiss
    @State private var showAlert = false // Add state variable for showing alert
    @State private var alertMessage = "" // Add state variable for alert message
    
    var course: Course
    
    var body: some View {
        VStack {
            TextField("Content Title", text: $contentTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())            
                .padding()
            
            TextField("Video URL", text: $videoURL)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
          
            
            Button(action: {
                let content = CourseContents(title: contentTitle, description: description, videoURL: videoURL)
                
                // Add functionality to save content title, video URL, and description to the database
                fireDBHelper.addContent(content: content, courseId: course.id!)
                showAlert = true
                alertMessage = "Course successfully added"
                
                dismiss()
            }) {
                Text("Add Content")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Success"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
                
            }
            Spacer()
        }
        .padding()
    }
}

struct AddCourseContentView_Previews: PreviewProvider {
    static var previews: some View {
        AddCourseContentView(course: Course())
    }
}
