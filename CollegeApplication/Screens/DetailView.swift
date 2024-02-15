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
    @State private var alertMsg: Alert = Alert(title: Text(""))
    @State private var showAlert: Bool = false
    
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
            if user is Student {
                let student = user as? Student
                if student?.courseGrade[course.id.uuidString] == nil{
                    Button("Add Course", action: {
                        self.showAlert = true
                        if (course.addStudent(student: student!)) {
                            student?.addCourse(courseId: course.id.uuidString)
                            self.isActive = true
                            alertMsg = Alert(title: Text("Success"),message: Text("Successfully registered to the course"))
                        } else {
                            alertMsg = Alert(title: Text("Error"),message: Text("Error: Exceed max number of students"))
                        }
                        
                    }).navigationDestination(isPresented: $isActive){
                        MainView().environmentObject(user)
                    }
                    .alert(isPresented: $showAlert, content: {
                                        alertMsg
                    })
                }else{
                    Text("Grade: \(student?.courseGrade[course.id.uuidString] ?? 0 )")
                }
            }
        }
        .navigationTitle(course.courseName)
    }
}



#Preview {
    DetailView(course: Course(courseName: "C-Course", courseDesc: "Test C", studentLimit: 35, startDate: Date(), endDate: Date().addingTimeInterval(3600 * 24 * 12), instructorList: ["aaa", "bbb"])).environmentObject(User())
}
