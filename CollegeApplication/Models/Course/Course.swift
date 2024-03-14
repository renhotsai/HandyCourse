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
    var courseCategories : CourseCategory
    var coursePrice : Double
    var courseImageName: String? // New property for the image name
    var contents: [CourseContents] = []

    
    var description: String {
       // return "id: \(id), Course Name: \(courseName), Course Desc: \(courseDesc), Instructors: \(instructorList)"
        return "students : \(self.studentGrades)"
    }
    
    init(){
        self.courseName = ""
        self.courseDesc = ""
        self.studentLimit = 0
        self.startDate = Date()
        self.endDate = Date()
        self.courseCategories = .defaultCategory
        self.coursePrice = 0.0
    }
    
    // Updated initializers with the new property
    init(courseName: String, courseDesc: String, studentLimit: Int, startDate: Date, endDate: Date, coursePrice: Double,courseCategories : CourseCategory , courseImageName: String? = nil) {
        self.courseName = courseName
        self.courseDesc = courseDesc
        self.studentLimit = studentLimit
        self.startDate = startDate
        self.endDate = endDate
        self.courseImageName = courseImageName
        self.courseCategories = courseCategories
        self.coursePrice = coursePrice

    }
    
    init(courseName: String, courseDesc: String, studentLimit: Int, startDate: Date, endDate: Date, instructorList: [String], coursePrice: Double, courseCategories : CourseCategory, courseImageName: String? = nil ) {
        self.courseName = courseName
        self.courseDesc = courseDesc
        self.studentLimit = studentLimit
        self.startDate = startDate
        self.endDate = endDate
        self.instructorList = instructorList
        self.courseImageName = courseImageName
        self.courseCategories = courseCategories
        self.coursePrice = coursePrice


    }
    
    func addContent(content: CourseContents) {
        contents.append(content)
    }
}
