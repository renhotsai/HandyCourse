//
//  Course.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/8.
//

import Foundation

class Course : CustomStringConvertible, Identifiable{
    var id : UUID = UUID()
    var courseName : String = ""
    var courseDesc : String = ""
    var instructorList : [String] = []
    var studentList: [String] = []
    
    
    var description: String{
        return "id: \(id), Course Name: \(courseName), Course Desc: \(courseDesc), Instructors: \(instructorList)"
    }
    init(courseName: String, courseDesc: String){
        self.courseName = courseName
        self.courseDesc = courseDesc
    }
    
    init(courseName: String, courseDesc: String, instructorList: [String]) {
        self.courseName = courseName
        self.courseDesc = courseDesc
        self.instructorList = instructorList
    }
    
    func addInstructor(instructor: String){
        if !self.instructorList.contains(where:{$0 == instructor }){
            self.instructorList.append(instructor)
        }
    }
    
    func addStudent(student:String){
        if !self.studentList.contains(where:{$0 == student}){
            self.studentList.append(student)
        }
    }
}
