//
//  Content.swift
//  CollegeApplication
//
//  Created by 이현성 on 3/13/24.
//

import Foundation
import FirebaseFirestoreSwift

class CourseContents: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var title: String
    var description: String
    var videoURL: String
    var watched: Bool
    
    init(title: String, description: String, videoURL: String, watched: Bool = false) {
        self.title = title
        self.description = description
        self.videoURL = videoURL
        self.watched = watched 
        
    }
}

