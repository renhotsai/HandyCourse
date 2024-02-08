//
//  Course.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/8.
//

import Foundation

class Course : CustomStringConvertible{
    var id : UUID = UUID()
    var courseName : String = ""
    var courseDesc : String = ""
    var instructor : String = ""
    
    var description: String{
        return "id: \(id), Course Name: \(courseName), Course Desc: \(courseDesc), Instructor: \(instructor)"
    }
    
    init(courseName: String, courseDesc: String, instructor: String) {
        self.courseName = courseName
        self.courseDesc = courseDesc
        self.instructor = instructor
    }
}
