//
//  CourseManager.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/14/24.
//

import Foundation

class CourseManager: ObservableObject {
    static let shared = CourseManager()
    
    @Published var courses: [Course] = []
    
    func addCourse(course: Course) {
        courses.append(course)
    }
}
