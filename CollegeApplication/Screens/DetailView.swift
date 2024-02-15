//
//  DetailView.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/12.
//

import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject var user: User
    var course: Course
    @State private var isActive: Bool = false
    @State private var alertMsg: Alert = Alert(title: Text(""))
    @State private var showAlert: Bool = false
    
    var body: some View {
        
        VStack {
            if let imageName = course.courseImageName {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .clipped()
            }
            Text("Description: \(course.courseDesc)")
                .font(.headline)
            Text("Instructors:")
                .font(.headline)
            ForEach(course.instructorList, id: \.self) { instructor in
                if let instructorObject = instructor as? Instructor {
                    Text("- \(instructorObject.name)")
                }
            }
            Text("Start Date: \(formattedDate(course.startDate))")
                .font(.headline)
            Text("End Date: \(formattedDate(course.endDate))")
                .font(.headline)
       
          
            Spacer()
            if user is Student {
                let student = user as? Student
                if student?.courseGrade[course.id.uuidString] == nil {
                    Button("Add Course", action: {
                        self.showAlert = true
                        if course.addStudent(student: student!) {
                            student?.addCourse(courseId: course.id.uuidString)
                            self.isActive = true
                            alertMsg = Alert(title: Text("Success"), message: Text("Successfully registered to the course"))
                        } else {
                            alertMsg = Alert(title: Text("Error"), message: Text("Error: Exceed max number of students"))
                        }
                        
                    })
                    .padding()
                    .alert(isPresented: $showAlert, content: {
                        alertMsg
                    })
                } else {
                    Text("This course added")
                }
            }
        }
        .navigationTitle(course.courseName)
    }
    func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(course: Course(courseName: "C-Course", courseDesc: "Test C", studentLimit: 35, startDate: Date(), endDate: Date().addingTimeInterval(3600 * 24 * 12), instructorList: ["aaa", "bbb"])).environmentObject(User())
    }
}
