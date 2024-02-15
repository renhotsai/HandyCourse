//
//  CourseMockData.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/9.
//

import Foundation

var courses: [Course] = [
    Course(courseName: "Mathematics", courseDesc: "Introduction to Calculus", studentLimit: 30, startDate: Date(), endDate: Date().addingTimeInterval(3600 * 24 * 30)), // 30 days after the start date
    Course(courseName: "Physics", courseDesc: "Fundamentals of Mechanics", studentLimit: 25, startDate: Date(), endDate: Date().addingTimeInterval(3600 * 24 * 45)), // 45 days after the start date
    Course(courseName: "Computer Science", courseDesc: "Introduction to Programming", studentLimit: 35, startDate: Date(), endDate: Date().addingTimeInterval(3600 * 24 * 60)) // 60 days after the start date
]
