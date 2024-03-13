//
//  StudentCourseDetailView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/14/24.
//

import SwiftUI

struct StudentCourseDetailView: View {
    @EnvironmentObject var fireDBHelper: FireDBHelper
    var course: Course

    var body: some View {
        TabView {
            CourseInfoView(course: course).environmentObject(fireDBHelper)
                .tabItem {
                    Label("Course Info", systemImage: "info.circle")
                }
            ContentsView(course: course).environmentObject(fireDBHelper)
                .tabItem {
                    Label("Contents", systemImage: "list.bullet")
                }
            GradesView(course: course)
                .tabItem {
                    Label("Grades", systemImage: "star.circle")
                }
        }
        .navigationTitle(course.courseName)
    }
}
