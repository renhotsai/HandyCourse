//
//  InstructorCoursesView.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/14.
//

import SwiftUI

struct InstructorCoursesView: View {
    @EnvironmentObject var user: Instructor

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(user.courseList) { course in
                        NavigationLink(destination: InstructorCourseDetailView()) {
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
                }
                .navigationBarTitle("My Courses")
                NavigationLink(destination: AddCourseView().environmentObject(user)) {
                    Text("Add Course")
                }
            }
        }
    }
}

#Preview {
    InstructorCoursesView().environmentObject(Instructor())
}
