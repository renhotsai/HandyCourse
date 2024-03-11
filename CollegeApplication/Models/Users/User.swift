//
//  User.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/8.
//

import Foundation

class User: Identifiable ,Codable{
    var id : String = ""
    var role : UserRole = .Student
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

    func addCourse(courseId:String){
        if !self.courses.contains(where: {$0 == courseId}){
            courses.append(courseId)
        }
    }
    
    func removeCourse(course: Course) {
        if let index = self.courses.firstIndex(where: { $0 == course.id}) {
            courses.remove(at: index)
            if let globalIndex = courses.firstIndex(where: { $0 == course.id}) {
                courses.remove(at: globalIndex)
            }
        }
    }
}
