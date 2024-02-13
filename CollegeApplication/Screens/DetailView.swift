//
//  DetailView.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/12.
//

import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject var user : User
    var course : Course
    @State private var isActive :Bool = false
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
            if ((user as? Student) != nil){
                Button("asdf", action: {
                    let student = user as? Student
                    student?.addCourse(courseId: course.id.uuidString)
                    self.isActive = true
                }).navigationDestination(isPresented: $isActive){
                    MainView().environmentObject(user)
                }
            }
        }
        .navigationTitle(course.courseName)
    }
}



#Preview {
    DetailView(course:Course(courseName: "C-Course", courseDesc: "Test C", instructorList: ["aaa","bbb"]))
}
