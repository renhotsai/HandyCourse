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
    var courseImageName: String? // New property for the image name
    
    var description: String {
        return "id: \(id), Course Name: \(courseName), Course Desc: \(courseDesc), Instructors: \(instructorList)"
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
    func addStudent(student: Student) -> Bool {
        if !studentList.contains(where: { $0.id == student.id }) {
            if studentList.count < studentLimit {
                studentList.append(student)
                return true
            }
        }
        
        return false
    }
}
