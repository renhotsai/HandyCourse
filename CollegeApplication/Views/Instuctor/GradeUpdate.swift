//
//  GradeUpdate.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/3/11.
//

import SwiftUI

struct GradeUpdate: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @State private var grade :String = "0"
    var course : Course
    var student : User
    var body: some View {
        VStack{
            Form {
                Text("Jack")
                TextField(text: $grade, label: {
                    Text("Grade")
                })
            }
            Spacer()
            Button(action: {
                guard let gradeInt = Int(grade) else{
                    print(#function, "Grade must be int")
                    return
                }
                fireDBHelper.updateStudentCourse(courseId: course.id!, studentId: student.id, grade: gradeInt)
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Update")
            })
        }.onAppear(){
            self.grade = String(course.studentGrades.first(where: {$0.studentId == student.id})!.grade)
        }
    }
}

#Preview {
    GradeUpdate(course: Course(),student: User())
}
