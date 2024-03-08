//
//  EditCourseView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/15/24.
//

import SwiftUI

struct EditCourseView: View {
//    @EnvironmentObject var user: Instructor
    var course: Course
    
    @State private var courseName: String
    @State private var courseDescription: String
    @State private var startDate: Date
    @State private var endDate: Date
    @State private var studentLimit: String
    @State private var showAlert = false // Add state variable for showing alert
    @State private var alertMessage = "" // Add state variable for alert message

    init(course: Course) {
        self.course = course
        
        // Initialize state properties with existing course details
        _courseName = State(initialValue: course.courseName)
        _courseDescription = State(initialValue: course.courseDesc)
        _startDate = State(initialValue: course.startDate)
        _endDate = State(initialValue: course.endDate)
        _studentLimit = State(initialValue: "\(course.studentLimit)")
    }
    
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
        
        // Optionally, you can reset the input fields here
        courseName = ""
        courseDescription = ""
        startDate = Date()
        endDate = Date()
        studentLimit = ""
        
        // Show success message
        showAlert = true
        alertMessage = "Course successfully updated"
    }
}

struct EditCourseView_Previews: PreviewProvider {
    static var previews: some View {
        let testCourse = Course(courseName: "C-Course", courseDesc: "Test C", studentLimit: 35, startDate: Date(), endDate: Date().addingTimeInterval(3600 * 24 * 12), instructorList: ["aaa", "bbb"])
        return EditCourseView(course: testCourse)
    }
}
