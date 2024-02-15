//
//  Student.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/8.
//

import Foundation

class Student : User{
    @Published var courseGrade:[String:Int] = [:]
    
    func addCourse(courseId:String){
        if !self.courseGrade.contains(where: {$0.key == courseId}){
            self.courseGrade[courseId] = 0
        }
    }
    
    func removeCourse(courseId:String){
        if let index = self.courseGrade.firstIndex(where: {$0.key == courseId}){
            self.courseGrade.remove(at: index)
        }
    }
    
    func editCourseGrade(courseId:String, grade:Int){
        if self.courseGrade.contains(where: {$0.key == courseId}){
            self.courseGrade[courseId] = grade            
        }
    }
}
