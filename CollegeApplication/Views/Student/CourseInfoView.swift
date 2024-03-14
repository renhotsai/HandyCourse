//
//  CourseInfoView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/14/24.
//

import SwiftUI

struct CourseInfoView: View {
    @EnvironmentObject var fireDBHelper: FireDBHelper
    @Environment(\.dismiss) private var dismiss
    @State private var showAlert = false
    
    var course: Course

    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .center, spacing: 20) {
                if let imageName = course.courseImageName {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .clipped()
                }
                Text("Description: \(course.courseDesc)")
                    .font(.headline)
                HStack {
                    Text("Instructor:")
                        .font(.headline)
                    if let instructorName = course.instructorList.first {
                        Text("\(instructorName)")
                            .font(.subheadline)
                    }
                }
                HStack {
                    Text("Start Date:")
                        .font(.headline)
                        .padding(.trailing, 10)
                    Text(formattedDate(course.startDate))
                        .font(.subheadline)
                        .padding(10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                HStack {
                    Text("End Date:")
                        .font(.headline)
                        .padding(.trailing, 10)
                    Text(formattedDate(course.endDate))
                        .font(.subheadline)
                        .padding(10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                
                Spacer()
                
                Button(action: {
                    showAlert = true
                }) {
                    Text("Delete Course")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Confirm Deletion"),
                        message: Text("Are you sure you want to delete this course?"),
                        primaryButton: .destructive(Text("Yes")) {
                            // Remove the course from the student's list of courses
                            fireDBHelper.user.removeCourse(course: self.course)
                            fireDBHelper.updateUser(user: fireDBHelper.user)
                            // Remove the student from the course's list of students
                            fireDBHelper.removeStudentCourse(courseId: course.id!, studentId: fireDBHelper.user.id)
                            // Dismiss the current view (CourseInfoView)
                            dismiss()
                        },
                        secondaryButton: .cancel(Text("No"))
                    )
                }
            }
            .padding()
            .navigationBarTitle(course.courseName)
        }
    }

    func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
}
