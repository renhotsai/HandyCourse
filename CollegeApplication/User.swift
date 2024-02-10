//
//  User.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/8.
//

import Foundation

class User : Identifiable, ObservableObject{
    var id : UUID = UUID()
    var name : String
    var username :String
    var password :String
    var email:String = ""

    init(name: String, username: String, password: String) {
        self.name = name
        self.username = username
        self.password = password
    }
}
