//
//  InstructorCoursesView.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/14.
//

import SwiftUI

struct InstructorCoursesView: View {
    @EnvironmentObject var fireDBHelper: FireDBHelper
    @State private var course : Course = Course()
    @State private var showAlert : Bool = false
    var body: some View {
        NavigationView {
            VStack {
                List {
                    let instructor = fireDBHelper.user
                    ForEach(fireDBHelper.courseList) { course in
                        if instructor.courses.contains(where: {$0 == course.id}){
                            NavigationLink(destination: InstructorCourseDetailView(course: course).environmentObject(fireDBHelper)) {
                                HStack {
                                    if let imageName = course.courseImageName {
                                        Image(imageName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(8)
                                    } else {
                                        Image("default")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(8)
                                    }
                                    Text(course.courseName)
                                }
                            }
                        }
                    }.onDelete(perform: { indexSet in
                        for index in indexSet{
                            self.course = fireDBHelper.courseList[index]
                            showAlert = true
                        }
                    })
                }.alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Confirm Deletion"),
                        message: Text("Are you sure you want to delete this course?"),
                        primaryButton: .destructive(Text("Yes")) {
                            deleteCourse()
                        },
                        secondaryButton: .cancel(Text("No"))
                    )
                }
                .navigationBarTitle("My Courses")
                NavigationLink(destination: AddCourseView().environmentObject(fireDBHelper)) {
                    Text("Add Course")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding()
                }
            }
        }
    }
    
    private func deleteCourse(){
        if(course.studentGrades.count == 0){
            fireDBHelper.deleteCourse(deleteCourse: course)
        }else{
            print(#function, "Course: \(course.courseName) can't delete. Student: \(course.studentGrades.count) ")
        }
    }
}

#Preview {
    InstructorCoursesView()
}
