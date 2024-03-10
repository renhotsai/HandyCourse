//
//  InstructorCourseInfoView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/14/24.
//

import SwiftUI

struct InstructorCourseInfoView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @Environment(\.dismiss) var dismiss
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
                
                NavigationLink(destination: EditCourseView(course: course).environmentObject(fireDBHelper)) {
                    Text("Update Course")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green) // Changed to light green
                        .cornerRadius(10)
                }
                .padding()
                
                
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
                            // Remove the course from the instructor's list of courses
                            deleteCourse()
                            // Dismiss the current view (InstructorCourseInfoView)
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
    
    func deleteCourse(){
        if(course.studentGrades.count == 0){
            fireDBHelper.deleteCourse(deleteCourse: course)
        }else{
            print(#function, "Course: \(course.courseName) can't delete. Student: \(course.studentGrades.count) ")
        }
    }
}


#Preview {
    InstructorCourseInfoView(course: Course())
}
