//
//  User.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/8.
//

import Foundation

class User : Identifiable, ObservableObject, Codable{
    var id : UUID = UUID()
    var name: String = ""
    var email:String = ""
    var address: String = ""
    var phoneNumber: String = ""
    var imageName: String?
    
    init(name: String, email: String, address: String, phoneNumber: String, imageName: String) {
        self.name = name
        self.email = email
        self.address = address
        self.phoneNumber = phoneNumber
        self.imageName = imageName
    }
    
    init(name: String, email: String, address: String, phoneNumber: String) {
        self.name = name
        self.email = email
        self.address = address
        self.phoneNumber = phoneNumber
    }
    
    init(email: String){
        self.email = email
    }
    
    init(){
        
    }
}
