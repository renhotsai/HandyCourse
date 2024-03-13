//
//  EditCourseView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/15/24.
//

import SwiftUI

struct EditCourseView: View {
    @EnvironmentObject var fireDBHelper :FireDBHelper
    @Environment(\.presentationMode) var presentationMode
    var course: Course
    
    @State private var courseName: String = ""
    @State private var courseDescription: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var studentLimit: String = ""
    
    @State private var showAlert = false // Add state variable for showing alert
    @State private var alertMessage = "" // Add state variable for alert message
    
    var body: some View {
        VStack {
            Text("Edit Course")
                .font(.title)
                .padding(.bottom, 20)
                .bold()
            
            TextField("Course Name", text: $courseName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Description", text: $courseDescription)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                .datePickerStyle(DefaultDatePickerStyle())
                .padding()

            DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                .datePickerStyle(DefaultDatePickerStyle())
                .padding()

            TextField("Student Limit", text: $studentLimit)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: updateCourse) {
                Text("Update Course")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Success"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear(){
            self.courseName = course.courseName
            self.courseDescription = course.courseDesc
            self.startDate = course.startDate
            self.endDate = course.endDate
            self.studentLimit = String(course.studentLimit)
        }
    }
    
    private func updateCourse() {
        guard let studentLimitInt = Int(studentLimit) else {
            // Handle invalid input
            return
        }
        
        // Update the course details
        course.courseName = courseName
        course.courseDesc = courseDescription
        course.startDate = startDate
        course.endDate = endDate
        course.studentLimit = studentLimitInt
        
        fireDBHelper.updateCourse(course: course)
        
        // Optionally, you can reset the input fields here
        courseName = ""
        courseDescription = ""
        startDate = Date()
        endDate = Date()
        studentLimit = ""
        
        // Show success message
        showAlert = true
        alertMessage = "Course successfully updated"
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    EditCourseView(course: Course())
}
