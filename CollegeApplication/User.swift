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
    
    init(name: String) {
        self.name = name
    }
}
