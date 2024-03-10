//
//  Course.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/8.
//

import Foundation
import FirebaseFirestoreSwift

class Course: CustomStringConvertible, Identifiable ,Codable{
    @DocumentID var id : String? = UUID().uuidString
    var courseName: String
    var courseDesc: String
    var instructorList: [String] = []
    var studentGrades : [StudentGrade] = []
    var studentLimit: Int
    var startDate: Date
    var endDate: Date
    var courseImageName: String? // New property for the image name
    
    
    var description: String {
        return "id: \(id), Course Name: \(courseName), Course Desc: \(courseDesc), Instructors: \(instructorList)"
    }
    
    init(){
        self.courseName = ""
        self.courseDesc = ""
        self.studentLimit = 0
        self.startDate = Date()
        self.endDate = Date()
    }
    
    // Updated initializers with the new property
    init(courseName: String, courseDesc: String, studentLimit: Int, startDate: Date, endDate: Date, courseImageName: String? = nil) {
        self.courseName = courseName
        self.courseDesc = courseDesc
        self.studentLimit = studentLimit
        self.startDate = startDate
        self.endDate = endDate
        self.courseImageName = courseImageName
    }
    
    init(courseName: String, courseDesc: String, studentLimit: Int, startDate: Date, endDate: Date, instructorList: [String], courseImageName: String? = nil) {
        self.courseName = courseName
        self.courseDesc = courseDesc
        self.studentLimit = studentLimit
        self.startDate = startDate
        self.endDate = endDate
        self.instructorList = instructorList
        self.courseImageName = courseImageName
    }
    
    // Function to add an instructor
    func addInstructor(instructor: String) {
        if !instructorList.contains(instructor) {
            instructorList.append(instructor)
        }
    }
    
    // Function to add a student
    func addStudent(studentId: String) -> Bool {
        if !studentGrades.contains(where: { $0.studentId == studentId }) {
            if studentGrades.count < studentLimit {
                var studentGrade = StudentGrade(studentId: studentId)
                studentGrades.append(studentGrade)
                return true
            }
        }
        
        return false
    }
}
