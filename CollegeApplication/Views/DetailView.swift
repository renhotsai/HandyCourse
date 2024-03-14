//
//  DetailView.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/12.
//

import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @Environment(\.dismiss) var dismiss
    
    var course: Course
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
            HStack {
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
                let student = fireDBHelper.user
                if student.courses.first(where: {$0 == course.id}) == nil {
                    Button(action: addCourse){
                        Text("Add Course")
                    }
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
    
    
    private func addStudent(studentId: String) -> Bool {
        if !course.studentGrades.contains(where: { $0.studentId == studentId }) {
            if course.studentGrades.count < course.studentLimit {
                var studentGrade = StudentGrade(studentId: studentId)

                fireDBHelper.addStudentCourse(courseId: course.id!, studentId: studentId)
                return true
            }
        }
        return false
    }
    
    private func addCourse(){
        let student = fireDBHelper.user
        print("Student: \(student.id)")
        self.showAlert = true
        if addStudent(studentId: student.id) {
            student.addCourse(courseId: course.id!)
            fireDBHelper.updateUser(user: student)
            alertMsg = Alert(title: Text("Success"), message: Text("Successfully registered to the course"))
        } else {
            alertMsg = Alert(title: Text("Error"), message: Text("Error: Exceed max number of students"))
        }
        dismiss()
    }
    
    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
}


#Preview {
    DetailView(course: Course())
}
