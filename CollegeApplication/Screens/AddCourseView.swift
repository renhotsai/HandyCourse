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

    
    var body: some View {
        VStack {
            Text("Add New Course")
                .font(.title)
                .padding(.bottom, 20)
            
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
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
    }
    
    private func addCourse() {
        guard let studentLimitInt = Int(studentLimit) else {
            // Handle invalid input
            return
        }
        
        let newCourse = Course(courseName: courseName,
                               courseDesc: courseDescription,
                               studentLimit: studentLimitInt,
                               startDate: startDate,
                               endDate: endDate)
            
        
        user.addCourse(course: newCourse)
        
        // Optionally, you can reset the input fields here
        courseName = ""
        courseDescription = ""
        startDate = Date()
        endDate = Date()
        studentLimit = ""
    }

}

struct AddCourseView_Previews: PreviewProvider {
    static var previews: some View {
        AddCourseView()
    }
}
