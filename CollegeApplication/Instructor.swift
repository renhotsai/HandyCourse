//
//  Instructor.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/8.
//

import Foundation

class Instructor : User{
    @Published var courseList:[Course] = []
    
    func addCourse(course:Course){
        if !self.courseList.contains(where: {$0.id == course.id}){
            courseList.append(course)
            courses.append(course)
        }
        
    }
    
    func removeCourse(course: Course) {
        if let index = self.courseList.firstIndex(where: { $0.id == course.id }) {
            courseList.remove(at: index)
            if let globalIndex = courses.firstIndex(where: { $0.id == course.id }) {
                courses.remove(at: globalIndex)
            }
        }
    }

}
