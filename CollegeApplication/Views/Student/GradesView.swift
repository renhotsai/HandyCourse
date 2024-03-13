//
//  GradesView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/14/24.
//

import SwiftUI

struct GradesView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    var course:Course
    var body: some View {
        VStack{
            Text(course.courseName)
            if let studentGrade = course.studentGrades.first(where: {$0.studentId == fireDBHelper.user.id}){
                Text("\(studentGrade.grade)")
            }
            Spacer()
        }
    }
}

#Preview {
    GradesView(course:Course())
}
