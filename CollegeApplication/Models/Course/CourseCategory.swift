//
//  CourseCategory.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/3/14.
//

import Foundation

enum CourseCategory: String, Codable, CaseIterable {
    case tech = "Tech"
    case dataScience = "Data Science"
    case business = "Business"
    case language = "Language"
    case art = "Art"
    case personalDev = "Personal Dev"
    
    static let defaultCategory: CourseCategory = .tech
    
}
