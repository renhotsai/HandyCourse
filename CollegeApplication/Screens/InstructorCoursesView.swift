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
                    }, label: {
                        Text(course.courseName)
                    })
                }
            }
            NavigationLink(destination: {
                AddCourseView().environmentObject(user)
            }, label: {
                Text("Add Course").foregroundColor(.white).bold()
            }).padding(.all)
                .frame(maxWidth: .infinity).background(.blue)
        }
    }
}

#Preview {
    InstructorCoursesView().environmentObject(Instructor(name: "Hyun", username: "hyun", password: "hyun", email: "devhyun05@gmail.com", address: "83 greenwin village rd", phoneNumber: "437-223-7368", imageName: "hyun-image"))
}
