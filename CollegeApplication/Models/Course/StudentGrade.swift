//
//  StudentGrade.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/3/7.
//

import Foundation
import FirebaseFirestoreSwift

struct StudentGrade : Codable{
    var studentId : String
    var grade : Int = 0
}
