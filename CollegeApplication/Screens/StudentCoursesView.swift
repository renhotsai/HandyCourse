//
//  StudentCoursesView.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/14.
//

import SwiftUI

struct StudentCoursesView: View {
    @EnvironmentObject var user : Student
    var body: some View {
        VStack{
            List{
                ForEach(user.courseGrade.keys.sorted(), id: \.self){ courseId in
                    let course = courses.first(where: {$0.id.uuidString == courseId})!
                    Text("\(course.courseName) : \(user.courseGrade[courseId]!)")
                }
            }
        }
    }
}

#Preview {
    StudentCoursesView().environmentObject(Student())
}
