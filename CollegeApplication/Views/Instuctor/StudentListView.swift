//
//  StudentListView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/14/24.
//

import SwiftUI


struct StudentListView: View {
    @EnvironmentObject var fireDBHelper: FireDBHelper
    var course: Course

    var body: some View {
        List(course.studentGrades, id: \.studentId) { studentGrade in
            var student = fireDBHelper.userList.first(where: {$0.id == studentGrade.studentId})!
            NavigationLink(destination: {GradeUpdate(course:course,student:student).environmentObject(fireDBHelper)}, label: {
                HStack{
                    Text(student.name).padding()
                    Spacer()
                    Text("Grade: \(course.studentGrades.first(where: {$0.studentId == student.id})!.grade)")
                }
            })
        }
        .navigationTitle("Enrolled Students")
    }
}


#Preview {
    StudentListView(course: Course())
}
