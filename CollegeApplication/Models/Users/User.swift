//
//  User.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/8.
//

import Foundation

struct User: Identifiable ,Codable{
    var id : String = ""
    var role : UserRole
    var name: String = ""
    var email:String = ""
    var address: String = ""
    var phoneNumber: String = ""
    var imageName: String?
    var courses : [String] = []
    
    init(id: String, email: String, userRole: UserRole){
        self.id = id
        self.email = email
        self.role = userRole
    }
    
    init(){
        
    }

    mutating func addCourse(course:Course){
        if !self.courses.contains(where: {$0 == course.id.uuidString}){
            courses.append(course.id.uuidString)
        }
    }
    
    mutating func removeCourse(course: Course) {
        if let index = self.courses.firstIndex(where: { $0 == course.id.uuidString }) {
            courses.remove(at: index)
            if let globalIndex = courses.firstIndex(where: { $0 == course.id.uuidString }) {
                courses.remove(at: globalIndex)
            }
        }
    }
}
