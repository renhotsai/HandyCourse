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
    private let FIELD_PHONE : String = "phoneNumber"
    private let FIELD_IMAGE : String = "imageName"
    private let FIELD_COURSES : String = "courses"
    
    @Published var user : User = User()
    @Published var userList : [User] = []
 
    private let COLLECTION_COURSES : String = "courses"
    private let FIELD_COURSENAME :String = "courseName"
    private let FIELD_COURSEDESC : String = "courseDesc"
    private let FIELD_INSTRUCTOR : String="instructorList"
    private let FIELD_STUDENTGRADES :String = "studentGrades"
    private let FIELD_STUDENTLIMIT :String = "studentLimit"
    private let FIELD_STARTDATE :String = "startDate"
    private let FIELD_ENDDATE : String = "endDate"
    private let FIELD_COURSEIMAGENAME : String = "courseImageName"
    
    
    @Published var courseList : [Course] = []
    
    init(db : Firestore){
        self.db = db
    }
    
    static func getInstance() -> FireDBHelper{
        if (shared == nil){
            shared = FireDBHelper(db: Firestore.firestore())
        }
        
        return shared!
    }
    
    //insert User
    func insertUser(user : User){
        do{
            try self.db
                .collection(COLLECTION_USERS)
                .addDocument(from: user)
        }catch let err as NSError{
            print(#function, "Unable to add document to firestore : \(err)")
        }
    }
    
    //get User
    func getUser(email: String) {
        db.collection(COLLECTION_USERS).whereField(FIELD_EMAIL, isEqualTo: email).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting user documents: \(error.localizedDescription)")
                return
            }

            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }

            if documents.count > 0 {
                // Assuming there's only one user with the given email
                let document = documents[0]
                if let user = try? document.data(as: User.self) {
                    self.user = user
                } else {
                    print("Error parsing user data")
                }
            } else {
                print("User document does not exist")
            }
        }
    }

    //get UserList
    
    //update User
    func updateUser(user:User){
        self.db.collection(COLLECTION_USERS)
            .document(user.id)
            .updateData([FIELD_NAME: user.name,
                        FIELD_EMAIL: user.email,
                      FIELD_ADDRESS:user.address,
                        FIELD_PHONE:user.phoneNumber,
                      FIELD_COURSES:user.courses,
                        FIELD_IMAGE: user.imageName,
                        ]){ error in
                
                if let err = error{
                    print(#function, "Unable to update document : \(err)")
                }else{
                    print(#function, "successfully updated : \(user.id)")
                }
            }
    }
    
    
    //insert Course
    func insertCourse(course : Course){
        do{
            let newcourse = try self.db
                .collection(COLLECTION_COURSES)
                .addDocument(from: course)
            user.courses.append(newcourse.documentID)
            updateUser(user: user)
        }catch let err as NSError{
            print(#function, "Unable to add document to firestore : \(err)")
        }
    }
    
    //get Course
    
    //get CourseList
    
    //update Course
    func updateUser(course:Course){
        self.db.collection(COLLECTION_COURSES)
            .document(course.id!)
            .updateData([
                FIELD_COURSENAME :course.courseName,
                FIELD_COURSEDESC : course.courseDesc,
                FIELD_INSTRUCTOR : course.instructorList,
                FIELD_STUDENTGRADES :course.studentGrades,
                FIELD_STUDENTLIMIT :course.studentLimit,
                FIELD_STARTDATE :course.startDate,
                FIELD_ENDDATE : course.endDate,
                FIELD_COURSEIMAGENAME : course.courseImageName
            ]){ error in
                
                if let err = error{
                    print(#function, "Unable to update document : \(err)")
                }else{
                    print(#function, "successfully updated : \(course.id)")
                }
            }
    }
}
