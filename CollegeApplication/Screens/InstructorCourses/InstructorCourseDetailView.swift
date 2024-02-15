//
//  InstructorCourseDetailView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/14/24.
//

import SwiftUI

struct InstructorCourseDetailView: View {
    var body: some View {
        TabView {
            InstructorCourseInfoView()
                .tabItem {
                    Label("Course Info", systemImage: "info.circle")
                }
            ContentsView()
                .tabItem {
                    Label("Contents", systemImage: "list.bullet")
                }
            StudentListView()
                .tabItem {
                    Label("Students", systemImage: "person.2")
                }
        }
    }
}

struct InstructorCourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        InstructorCourseDetailView()
    }
}
