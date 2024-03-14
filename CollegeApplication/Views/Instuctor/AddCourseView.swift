//
//  AddNewCourseView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/14/24.
//

import SwiftUI

struct AddCourseView: View {
    @EnvironmentObject var fireDBHelper: FireDBHelper
    @Environment(\.dismiss) private var dismiss
    
    @State private var courseName = ""
    @State private var courseDescription = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var studentLimit = ""
    @State private var showAlert = false // Add state variable for showing alert
    @State private var alertMessage = "" // Add state variable for alert message
    @State private var coursePrice = 0.0
    @State private var courseCategory: CourseCategory = .defaultCategory // New state variable for course category
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Add New Course")
                    .font(.title)
                    .padding(.bottom, 20)
                    .bold()
                
                // Course Name
                VStack(alignment: .leading) {
                    Text("Course Name")
                        .bold()
                    TextField("Enter course name", text: $courseName)
                        .padding(.all, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black.opacity(0.2), lineWidth: 1)
                        )
                }
                .padding()
                
                // Course Description
                VStack(alignment: .leading) {
                    Text("Course Description")
                        .bold()
                    TextEditor(text: $courseDescription)
                        .frame(height: 100)
                        .padding(.all, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black.opacity(0.2), lineWidth: 1)
                        )
                        .foregroundColor(.gray)
                }
                .padding()
                
                // Course Price
                VStack(alignment: .leading) {
                    Text("Course Price")
                        .bold()
                    TextField("Enter course price", value: $coursePrice, formatter: NumberFormatter())
                        .padding(.all, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black.opacity(0.2), lineWidth: 1)
                        )
                }
                .padding()
                
                // Student Limit
                VStack(alignment: .leading) {
                    Text("Student Limit")
                        .bold()
                    TextField("Enter student limit", text: $studentLimit)
                        .padding(.all, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black.opacity(0.2), lineWidth: 1)
                        )
                }
                .padding()
                
                // Course Category Picker
                HStack() {
                    Text("Category")
                        .bold()
                    
                    Spacer()
                    Picker("Category", selection: $courseCategory) {
                        ForEach(CourseCategory.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    .pickerStyle(.menu)
                }
                .padding()
                
                // Start Date
                HStack() {
                    Text("Start Date")
                        .bold()
                    
                    Spacer()
                    DatePicker("", selection: $startDate, displayedComponents: .date)
                        .datePickerStyle(DefaultDatePickerStyle())
                }
                .padding()
                
                // End Date
                HStack() {
                    Text("End Date")
                        .bold()
                    
                    Spacer()
                    DatePicker("", selection: $endDate, displayedComponents: .date)
                        .datePickerStyle(DefaultDatePickerStyle())
                }
                .padding()
                
                // Add Course Button
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
    }
    
    private func addCourse() {
        // Check if any required field is empty
        guard !courseName.isEmpty else {
            showAlert(title: "Error", message: "Course name cannot be empty.")
            return
        }
        
        guard !courseDescription.isEmpty else {
            showAlert(title: "Error", message: "Course description cannot be empty.")
            return
        }
        
        guard let studentLimitInt = Int(studentLimit), studentLimitInt > 0 else {
            showAlert(title: "Error", message: "Please enter a valid student limit.")
            return
        }
        
        guard coursePrice >= 0.0 else {
            showAlert(title: "Error", message: "Please enter a valid course price.")
            return
        }
        
        // Create a new course and add the current instructor's name to the instructor list
        let newCourse = Course(
            courseName: courseName,
            courseDesc: courseDescription,
            studentLimit: studentLimitInt,
            startDate: startDate,
            endDate: endDate,
            instructorList: [fireDBHelper.user.id],
            coursePrice: coursePrice,
            courseCategories: courseCategory // Assign the selected course category
        )
            
        // Add the new course to the instructor's course list
        fireDBHelper.insertCourse(course: newCourse)
        // Optionally, you can reset the input fields here
        courseName = ""
        courseDescription = ""
        startDate = Date()
        endDate = Date()
        studentLimit = ""
        coursePrice = 0.0
        courseCategory = .defaultCategory
        
        // Show success message
        showAlert(title: "Success", message: "Course successfully added.")
        dismiss()
    }

    // Function to show alert
    private func showAlert(title: String, message: String) {
        self.showAlert = true
        self.alertMessage = message
    }

}





#Preview {
    AddCourseView( )
}
