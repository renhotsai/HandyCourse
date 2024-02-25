//
//  InstructorCourseDetailView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/14/24.
//

import SwiftUI

struct InstructorCourseDetailView: View {
    var course: Course
    var body: some View {
        TabView {
            InstructorCourseInfoView(course: course)
                .tabItem {
                    Label("Course Info", systemImage: "info.circle")
                }
            ContentsView()
                .tabItem {
                    Label("Contents", systemImage: "list.bullet")
                }
            StudentListView(course: course)
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
