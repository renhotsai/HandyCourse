//
//  FireDBHelper.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/25.
//

import Foundation
import FirebaseFirestore

class FireDBHelper : ObservableObject{
    private let db : Firestore
    private static var shared : FireDBHelper?
    
    private let COLLECTION_USERS : String = "users"
    private let FIELD_NAME : String = "name"
    private let FIELD_EMAIL : String = "email"
    private let FIELD_ADDRESS : String = "address"
    private let FIELD_PHONE : String = "phone"
    private let FIELD_IMAGE : String = "image"
    
    
    @Published var user : User = User()
    
    init(db : Firestore){
        self.db = db
    }
    
    static func getInstance() -> FireDBHelper{
        if (shared == nil){
            shared = FireDBHelper(db: Firestore.firestore())
        }
        
        return shared!
    }
    
    func insertUser(user:User){
        do{
            try self.db
                .collection(COLLECTION_USERS)
                .addDocument(from: user)
        }catch let err as NSError{
            print(#function, "Unable to add document to firestore : \(err)")
        }
    }
}
