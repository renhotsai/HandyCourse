//
//  User.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/8.
//

import Foundation

class User : Identifiable, ObservableObject{
    var id : UUID = UUID()
    var name: String
    var username: String
    var password: String
    var email:String = ""
    var address: String = ""
    var phoneNumber: String = ""
    var imageName: String = ""
    
    init(name: String, username: String, password: String, email: String, address: String, phoneNumber: String, imageName: String) {
        self.name = name
        self.username = username
        self.password = password
        self.email = email
        self.address = address
        self.phoneNumber = phoneNumber
        self.imageName = imageName 
    }
    
    init(){
        self.name = "NA"
        self.username = "NA"
        self.password = "NA"
        self.email = "NA"
        self.address = "NA"
        self.phoneNumber = "NA"
        self.imageName = "NA"
        
    }
}
