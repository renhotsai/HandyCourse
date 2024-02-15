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
        
        VStack(alignment: .leading) {
            if let imageName = course.courseImageName {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .clipped()
            }
            
            // Instructors
            HStack {
                Text("Instructor:")
                    .font(.headline)
                    .padding(.trailing, 10)
                
                VStack(alignment: .leading, spacing: 5) {
                    if let instructorName = course.instructorList.first {
                        Text("\(instructorName)")
                            .font(.subheadline)
                    }
                }
            }
            .padding(.vertical, 10)
            
            // Description
            HStack {
                Text("Description:")
                    .font(.headline)
                    .padding(.trailing, 10)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(course.courseDesc)")
                        .font(.body)
                }
            }
            .padding(.vertical, 10)
            
            // Start and End Date
            HStack(spacing: 25) {
                VStack(alignment: .leading) {
                    Text("Start Date:")
                        .font(.headline)
                    Text(formattedDate(course.startDate))
                        .font(.subheadline)
                }
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                
                VStack(alignment: .leading) {
                    Text("End Date:")
                        .font(.headline)
                    Text(formattedDate(course.endDate))
                        .font(.subheadline)
                }
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            }
            .padding(.vertical, 10)
            
            Spacer()
            
            // Add Course Button
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
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding()

                } else {
                    Text("This course is added")
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow)
                        .cornerRadius(10)
                        .padding()
                }
            }
        }
        .alert(isPresented: $showAlert, content: {
            alertMsg
        })
        .padding()
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
