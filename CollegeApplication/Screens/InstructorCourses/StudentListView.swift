//
//  StudentListView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/14/24.
//

import SwiftUI


struct StudentListView: View {
    var course: Course

    var body: some View {
        List(course.studentList) { student in
            Text(student.name) // Displaying only the student name
                .padding()
        }
        .navigationTitle("Enrolled Students")
    }
}


struct StudentListView_Previews: PreviewProvider {
    static var previews: some View {
        let testCourse = Course(courseName: "Test Course", courseDesc: "Description", studentLimit: 20, startDate: Date(), endDate: Date().addingTimeInterval(3600 * 24 * 30))
        return StudentListView(course: testCourse)
    }
}
