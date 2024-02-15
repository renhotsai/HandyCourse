//
//  Course.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/8.
//

import Foundation

class Course: CustomStringConvertible, Identifiable {
    var id: UUID = UUID()
    var courseName: String
    var courseDesc: String
    var instructorList: [String] = []
    var studentList: [Student] = []
    var studentLimit: Int
    var startDate: Date
    var endDate: Date
    
    var description: String {
        return "id: \(id), Course Name: \(courseName), Course Desc: \(courseDesc), Instructors: \(instructorList)"
    }
    
    init(courseName: String, courseDesc: String, studentLimit: Int, startDate: Date, endDate: Date) {
        self.courseName = courseName
        self.courseDesc = courseDesc
        self.studentLimit = studentLimit
        self.startDate = startDate
        self.endDate = endDate
    }
    
    init(courseName: String, courseDesc: String, studentLimit: Int, startDate: Date, endDate: Date, instructorList: [String]) {
        self.courseName = courseName
        self.courseDesc = courseDesc
        self.studentLimit = studentLimit
        self.startDate = startDate
        self.endDate = endDate
        self.instructorList = instructorList
    }
    
    func addInstructor(instructor: String) {
        if !instructorList.contains(instructor) {
            instructorList.append(instructor)
        }
    }
    
    func addStudent(student: Student) {
        if !studentList.contains(where: { $0.id == student.id }) {
            studentList.append(student)
        }
    }
}

