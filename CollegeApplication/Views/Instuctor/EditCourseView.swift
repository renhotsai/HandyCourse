//
//  EditCourseView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/15/24.
//

import SwiftUI

struct EditCourseView: View {
    @EnvironmentObject var fireDBHelper: FireDBHelper
    @Environment(\.presentationMode) var presentationMode
    var course: Course
    
    @State private var courseName: String = ""
    @State private var courseDescription: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var studentLimit: String = ""
    @State private var coursePrice: String = ""
    @State private var courseCategory: CourseCategory = .defaultCategory
    
    @State private var showAlert = false // Add state variable for showing alert
    @State private var alertMessage = "" // Add state variable for alert message
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Edit Course")
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
                .padding(10)
                
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
                .padding(10)
                
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
                .padding(10)
                
                // Course Price
                VStack(alignment: .leading) {
                    Text("Course Price")
                        .bold()
                    TextField("Enter course price", text: $coursePrice)
                        .padding(.all, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black.opacity(0.2), lineWidth: 1)
                        )
                }
                .padding(10)
                
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
                .padding(10)
                
                // Start Date
                HStack() {
                    Text("Start Date")
                        .bold()
                    
                    Spacer()
                    DatePicker("", selection: $startDate, displayedComponents: .date)
                        .datePickerStyle(DefaultDatePickerStyle())
                }
                .padding(10)
                
                // End Date
                HStack() {
                    Text("End Date")
                        .bold()
                    
                    Spacer()
                    DatePicker("", selection: $endDate, displayedComponents: .date)
                        .datePickerStyle(DefaultDatePickerStyle())
                }
                .padding(10)
                
                // Update Course Button
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
            .onAppear() {
                // Populate fields with existing course data
                self.courseName = course.courseName
                self.courseDescription = course.courseDesc
                self.startDate = course.startDate
                self.endDate = course.endDate
                self.studentLimit = String(course.studentLimit)
                self.coursePrice = String(course.coursePrice)
                self.courseCategory = course.courseCategories
            }
        }
    }
    
    private func updateCourse() {
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
        
        guard let coursePriceDouble = Double(coursePrice) else {
            showAlert(title: "Error", message: "Please enter a valid course price.")
            return
        }
        
        // Update the course details
        course.courseName = courseName
        course.courseDesc = courseDescription
        course.startDate = startDate
        course.endDate = endDate
        course.studentLimit = studentLimitInt
        course.coursePrice = coursePriceDouble
        course.courseCategories = courseCategory
        
        // Call the function to update the course
        fireDBHelper.updateCourse(course: course)
        
        // Show success message
        showAlert(title: "Success", message: "Course successfully updated.")
        presentationMode.wrappedValue.dismiss()
    }

    // Function to show alert
    private func showAlert(title: String, message: String) {
        self.showAlert = true
        self.alertMessage = message
    }
}



#Preview {
    EditCourseView(course: Course())
}
