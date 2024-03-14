//
//  StudentCoursesView.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/14.
//

import SwiftUI

struct StudentCoursesView: View {
    @EnvironmentObject var fireDBHelper: FireDBHelper

    var body: some View {
        VStack {
            List {
                let student = fireDBHelper.user
                ForEach(fireDBHelper.courseList) { course in
                    if student.courses.contains(where: { $0 == course.id }) {
                        NavigationLink(destination: StudentCourseDetailView(course: course).environmentObject(fireDBHelper)) {
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
                }
            }
            .navigationBarTitle("My Courses") // Set the navigation bar title
        }
    }

    func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd" // Format: Year.Month.Day
        return dateFormatter.string(from: date)
    }
}






#Preview {
    StudentCoursesView()
}
