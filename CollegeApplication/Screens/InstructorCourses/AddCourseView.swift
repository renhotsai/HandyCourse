//
//  AddNewCourseView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/14/24.
//

import SwiftUI

struct AddCourseView: View {
    @EnvironmentObject var user: Instructor
    
    @State private var courseName = ""
    @State private var courseDescription = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var studentLimit = ""
    @State private var showAlert = false // Add state variable for showing alert
    @State private var alertMessage = "" // Add state variable for alert message
    
    var body: some View {
        VStack {
            Text("Add New Course")
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

            Button(action: addCourse) {
                Text("Add Course")
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
    }
    
    private func addCourse() {
        guard let studentLimitInt = Int(studentLimit) else {
            // Handle invalid input
            return
        }
        
        // Get the current instructor's name
        let instructorName = user.name
        
        // Create a new course and add the current instructor's name to the instructor list
        let newCourse = Course(courseName: courseName,
                               courseDesc: courseDescription,
                               studentLimit: studentLimitInt,
                               startDate: startDate,
                               endDate: endDate,
                               instructorList: [instructorName])
            
        // Add the new course to the instructor's course list
        user.addCourse(course: newCourse)
        
        // Optionally, you can reset the input fields here
        courseName = ""
        courseDescription = ""
        startDate = Date()
        endDate = Date()
        studentLimit = ""
        
        // Show success message
        showAlert = true
        alertMessage = "Course successfully added"
    }
}

struct AddCourseView_Previews: PreviewProvider {
    static var previews: some View {
        AddCourseView()
    }
}
