//
//  InstructorCourseDetailView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/14/24.
//

import SwiftUI

struct InstructorCourseDetailView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    var course: Course
    var body: some View {
        TabView {
            InstructorCourseInfoView(course: course).environmentObject(fireDBHelper)
                .tabItem {
                    Label("Course Info", systemImage: "info.circle")
                }
            InstructorContentView(course:course).environmentObject(fireDBHelper)
                .tabItem {
                    Label("Contents", systemImage: "list.bullet")
                }
            StudentListView(course: course).environmentObject(fireDBHelper)
                .tabItem {
                    Label("Students", systemImage: "person.2")
                }
        }
    }
}

struct InstructorCourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let testCourse = Course(courseName: "Test Course", courseDesc: "Description", studentLimit: 20, startDate: Date(), endDate: Date().addingTimeInterval(3600 * 24 * 30), instructorList: ["Instructor"])
        return InstructorCourseDetailView(course: testCourse)
    }
}
