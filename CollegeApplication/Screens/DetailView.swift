//
//  DetailView.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/12.
//

import SwiftUI

struct DetailView: View {
    var course : Course
    var body: some View {
        VStack{
            Text(course.courseDesc)
            HStack{
            Text("Instructor:")
                ForEach(course.instructorList,id: \.self){ instructor in
                    Text(instructor)
                }
            }
            Spacer()
        }
        .navigationTitle(course.courseName)
    }
}

#Preview {
    DetailView(course:Course(courseName: "C-Course", courseDesc: "Test C", instructorList: ["aaa","bbb"]))
}
