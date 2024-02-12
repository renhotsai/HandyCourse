//
//  ErrorCode.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/9.
//

import Foundation

enum ErrorCode : Error{
    case EmptyUsername
    case EmptyPassword
    case WrongUsername
    case WrongPassword
    
    var localizedDescription: String {
            switch self {
            case .EmptyUsername:
                return NSLocalizedString("Empty Username", comment: "")
            case .EmptyPassword:
                return NSLocalizedString("Empty Password", comment: "")
            case .WrongUsername:
                return NSLocalizedString("Wrong Username", comment: "")
            case .WrongPassword:
                return NSLocalizedString("Wrong Password", comment: "")
            }
        }
}
