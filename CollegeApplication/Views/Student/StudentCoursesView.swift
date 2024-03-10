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
        NavigationView {
            VStack {
                List {
                    let student = fireDBHelper.user
                    ForEach(fireDBHelper.courseList) { course in
                        if student.courses.contains(where: {$0 == course.id}){
                            NavigationLink(destination: StudentCourseDetailView(course: course)) {
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
                                    VStack(alignment: .leading) {
                                        Text(course.courseName)
                                            .font(.headline)
                                    }
                                }
                                .padding(.vertical)
                            }
                        }
                    }
                }
                .navigationBarTitle("My Courses") // Set the navigation bar title
            }
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
