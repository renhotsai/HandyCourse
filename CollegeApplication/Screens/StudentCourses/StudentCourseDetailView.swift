//
//  StudentCourseDetailView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/14/24.
//

import SwiftUI

struct StudentCourseDetailView: View {
    @EnvironmentObject var user: User
    var course: Course

    var body: some View {
        TabView {
            CourseInfoView(course: course)
                .tabItem {
                    Label("Course Info", systemImage: "info.circle")
                }
            ContentsView()
                .tabItem {
                    Label("Contents", systemImage: "list.bullet")
                }
            GradesView()
                .tabItem {
                    Label("Grades", systemImage: "star.circle")
                }
        }
        .navigationTitle(course.courseName)
    }
}

#Preview {
    StudentCourseDetailView(course: Course(courseName: "C-Course", courseDesc: "Test C", studentLimit: 35, startDate: Date(), endDate: Date().addingTimeInterval(3600 * 24 * 12), instructorList: ["aaa", "bbb"])).environmentObject(User())
}
