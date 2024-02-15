//
//  InstructorCoursesView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/14/24.
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
