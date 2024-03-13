//
//  ContentsView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/14/24.
//

import SwiftUI

struct ContentsView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    var course: Course
    
    var body: some View {
        VStack{
            Text(course.courseName)
            HStack{
                ForEach(course.instructorList, id: \.self){ instructorId in
                    if let instructor = fireDBHelper.userList.first(where: {$0.id == instructorId}){
                        Text(instructor.name)
                    }
                }
            }
            Text(course.courseDesc)
            Spacer()
        }
    }
}

#Preview {
    ContentsView(course: Course())
}
