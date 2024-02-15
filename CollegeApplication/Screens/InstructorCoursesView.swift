//
//  InstructorCoursesView.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/14.
//

import SwiftUI

struct InstructorCoursesView: View {
    @EnvironmentObject var user : Instructor
    var body: some View {
        VStack{
            List{
                ForEach(user.courseList){ course in
                    NavigationLink(destination: {
                        // Instructor Course Detail View
                        Text(course.courseName)
                    }, label: {
                        Text(course.courseName)
                    })
                }
            }
            NavigationLink(destination: {
                AddCourseView().environmentObject(user)
            }, label: {
                Text("Add Course")
            })
        }
    }
}

#Preview {
    InstructorCoursesView().environmentObject(Instructor())
}
