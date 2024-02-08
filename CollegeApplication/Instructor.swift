//
//  Instructor.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/8.
//

import Foundation

class Instructor : User{
    var courseList:[Course] = []
    
    func addCourse(course:Course){
        if !self.courseList.contains(where: {$0.id == course.id}){
            courseList.append(course)
        }
    }
    
    func removeCourse(course:Course){
        if let index = self.courseList.firstIndex(where: {$0.id == course.id}){
            courseList.remove(at: index)
        }
    }
}
