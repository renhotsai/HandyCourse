//
//  DetailView.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/12.
//

import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    var course: Course
    @State private var isActive: Bool = false
    @State private var alertMsg: Alert = Alert(title: Text(""))
    @State private var showAlert: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            if let imageName = course.courseImageName {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .clipped()
            } else {
                Image("default")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .clipped()
            }
            
            // Instructors
            HStack {
                Text("Instructor:")
                    .font(.headline)
                    .padding(.trailing, 10)
                
                VStack(alignment: .leading, spacing: 5) {
                    if let instructorName = course.instructorList.first {
                        Text("\(instructorName)")
                            .font(.subheadline)
                    }
                }
            }
            .padding(.vertical, 10)
            
            // Description
            HStack {
                Text("Description:")
                    .font(.headline)
                    .padding(.trailing, 10)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(course.courseDesc)")
                        .font(.body)
                }
            }
            .padding(.vertical, 10)
            
            // Start and End Date
            HStack(spacing: 25) {
                VStack(alignment: .leading) {
                    Text("Start Date:")
                        .font(.headline)
                    Text(formattedDate(course.startDate))
                        .font(.subheadline)
                }
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                
                VStack(alignment: .leading) {
                    Text("End Date:")
                        .font(.headline)
                    Text(formattedDate(course.endDate))
                        .font(.subheadline)
                }
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            }
            .padding(.vertical, 10)
            
            Spacer()
            
            // Add Course Button
            if fireDBHelper.user.role == .Student {
                var student = fireDBHelper.user
                if student.courses.first(where: {$0 == course.id.uuidString}) == nil {
                    Button("Add Course", action: {
                        self.showAlert = true
                        if course.addStudent(studentId: student.id) {
                            student.addCourse(course: course)
                            self.isActive = true
                            alertMsg = Alert(title: Text("Success"), message: Text("Successfully registered to the course"))
                        } else {
                            alertMsg = Alert(title: Text("Error"), message: Text("Error: Exceed max number of students"))
                        }
                        
                    })
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding()

                } else {
                    Text("This course is added")
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow)
                        .cornerRadius(10)
                        .padding()
                }
            }
        }
        .alert(isPresented: $showAlert, content: {
            alertMsg
        })
        .padding()
        .navigationTitle(course.courseName)
    }
    
    func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
}
