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
                                VStack(alignment: .leading) {
                                    if let imageName = course.courseImageName {
                                        Image(imageName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(maxWidth: .infinity, maxHeight: 125)
                                            .clipped()
                                    } else {
                                        Image("default")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(maxWidth: .infinity, maxHeight: 125)
                                            .clipped()
                                    }
                                    Text(course.courseName)
                                        .bold()
                                        .padding(.vertical, 5)

                                    Text("Category: \(course.courseCategories.rawValue)")
                                        .foregroundColor(.gray)
                                    
                                    Text("Duration: \(formattedDate(course.startDate)) ~ \(formattedDate(course.endDate))")
                                        .foregroundColor(.gray)
                                }
                                .padding(.top, 20)
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
    
    func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd" // Format: Year.Month.Day
        return dateFormatter.string(from: date)
    }
}

#Preview {
    InstructorCoursesView()
}
