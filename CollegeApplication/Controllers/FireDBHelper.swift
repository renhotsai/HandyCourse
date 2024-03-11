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
    private let FIELD_STUDENTLIMIT :String = "studentLimit"
    private let FIELD_STARTDATE :String = "startDate"
    private let FIELD_ENDDATE : String = "endDate"
    private let FIELD_COURSEIMAGENAME : String = "courseImageName"
    private let COLLECTION_STUDENTGRADES :String = "studentGrades"
    
    @Published var courseList = [Course]()
    
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
        self.user = user
        do{
            try self.db
                .collection(COLLECTION_USERS)
                .document(user.id)
                .setData(from: user)
        }catch let err as NSError{
            print(#function, "Unable to add document to firestore : \(err)")
        }
    }
    
    //get User
    func getUser(userId: String) {
        db.collection(COLLECTION_USERS).document(userId).addSnapshotListener({ querySnapshot, error in
            guard let snapshot = querySnapshot else{
                print(#function, "Unable to retrieve data from firestore : \(error)")
                return
            }
            do {
                // Attempt to decode the snapshot data into a User object
                self.user = try snapshot.data(as: User.self)
            } catch {
                print(#function, "Error decoding user data: \(error)")
            }
        })
    }

    //get UserList
    func getAllUsers(){
        self.db.collection(COLLECTION_USERS)
            .addSnapshotListener({ (querySnapshot, error) in
                guard let snapshot = querySnapshot else{
                    print(#function, "Unable to retrieve data from firestore : \(error)")
                    return
                }
                
                snapshot.documentChanges.forEach{ (docChange) in
                    
                    do{
                        
                        var user : User = try docChange.document.data(as: User.self)
                        user.id = docChange.document.documentID
                        
                        let matchedIndex = self.courseList.firstIndex(where: {($0.id?.elementsEqual(docChange.document.documentID))!})
                        
                        switch(docChange.type){
                        case .added:
                            print(#function, "Document added : \(docChange.document.documentID)")
                            self.userList.append(user)
                        case .modified:
                            //replace existing object with updated one
                            print(#function, "Document updated : \(docChange.document.documentID)")
                            if (matchedIndex != nil){
                                self.userList[matchedIndex!] = user
                            }
                        case .removed:
                            //remove object from index in bookList
                            print(#function, "Document removed : \(docChange.document.documentID)")
                            if (matchedIndex != nil){
                                self.userList.remove(at: matchedIndex!)
                            }
                        }
                        
                    }catch let err as NSError{
                        print(#function, "Unable to convert document into Swift object : \(err)")
                    }
                }//forEach
            })//addSnapshotListener
    }
    
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
            
            self.user.addCourse(courseId: newcourse.documentID)
            self.updateUser(user: self.user)
        }catch let err as NSError{
            print(#function, "Unable to add document to firestore : \(err)")
        }
    }
    
    //get CourseList
    func getAllCourses(){
        
        self.db.collection(COLLECTION_COURSES)
            .addSnapshotListener({ (querySnapshot, error) in
                guard let snapshot = querySnapshot else{
                    print(#function, "Unable to retrieve data from firestore : \(error)")
                    return
                }
                
                snapshot.documentChanges.forEach{ (docChange) in
                    
                    do{
                        var course : Course = try docChange.document.data(as: Course.self)
                        course.id = docChange.document.documentID
                        
                        let matchedIndex = self.courseList.firstIndex(where: {($0.id?.elementsEqual(docChange.document.documentID))!})
                        
                        switch(docChange.type){
                        case .added:
                            print(#function, "Document added : \(docChange.document.documentID)")
                            self.getStudentGrade(course: course)
                            self.courseList.append(course)
                        case .modified:
                            //replace existing object with updated one
                            print(#function, "Document updated : \(docChange.document.documentID)")
                            if (matchedIndex != nil){
                                self.courseList[matchedIndex!] = course
                            }
                        case .removed:
                            //remove object from index in bookList
                            print(#function, "Document removed : \(docChange.document.documentID)")
                            if (matchedIndex != nil){
                                self.courseList.remove(at: matchedIndex!)
                            }
                        }
                        
                    }catch let err as NSError{
                        print(#function, "Unable to convert document into Swift object : \(err)")
                    }
                }//forEach
            })//addSnapshotListener
    }
    
    func getStudentGrade(course: Course) {
        self.db.collection(COLLECTION_COURSES).document(course.id!).collection(COLLECTION_STUDENTGRADES)
            .addSnapshotListener({ (querySnapshot, error) in
                guard let snapshot = querySnapshot else{
                    print(#function, "Unable to retrieve data from firestore : \(error)")
                    return
                }
                
                snapshot.documentChanges.forEach { (docChange) in
                    do{
                        var studentGrade : StudentGrade = try docChange.document.data(as:StudentGrade.self)
                        let matchedIndex = course.studentGrades.firstIndex(where: {($0.studentId.elementsEqual(studentGrade.studentId))})
                        
                        switch(docChange.type) {
                        case .added:
                            print("Document added to studentGrades")
                            // Handle adding studentGrade to the course
                            course.studentGrades.append(studentGrade)
                        case .modified:
                            print("Document modified in studentGrades")
                            // Find the corresponding studentGrade in the course and update it
                            if let index = course.studentGrades.firstIndex(where: { $0.studentId == studentGrade.studentId}) {
                                course.studentGrades[index] = studentGrade
                            }
                        case .removed:
                            print("Document removed from studentGrades")
                            // Remove the studentGrade from the course
                            if let index = course.studentGrades.firstIndex(where: { $0.studentId == studentGrade.studentId }) {
                                course.studentGrades.remove(at: index)
                            }
                        }
                    }catch let err as NSError{
                        print(#function, "Unable to convert document into Swift object : \(err)")
                    }
                }
            })
    }

    
    //update Course
    func updateCourse(course:Course){
        self.db.collection(COLLECTION_COURSES)
            .document(course.id!)
            .updateData([
                FIELD_COURSENAME :course.courseName,
                FIELD_COURSEDESC : course.courseDesc,
                FIELD_INSTRUCTOR : course.instructorList,
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
    
    //addStudentCourse
    func addStudentCourse(courseId:String,studentId:String){
        do{
            try self.db
                .collection(COLLECTION_COURSES).document(courseId)
                .collection(COLLECTION_STUDENTGRADES).document(studentId).setData(from: StudentGrade(studentId: studentId))
        }catch let err as NSError{
            print(#function, "Unable to add document to firestore : \(err)")
        }
    }
    
    //removeStudentCourse
    func removeStudentCourse(courseId:String,studentId:String){
        self.db.collection(COLLECTION_COURSES).document(courseId)
            .collection(COLLECTION_STUDENTGRADES).document(studentId).delete{error in
                if let err = error{
                    print(#function, "Unable to delete document : \(err)")
                }else{
                    print(#function, "successfully deleted : \(studentId) in courseId: \(courseId)")
                }
            }
    }
    
    //delete Course
    func deleteCourse(deleteCourse : Course){
        self.db.collection(COLLECTION_COURSES)
            .document(deleteCourse.id!)
            .delete{error in
                if let err = error{
                    print(#function, "Unable to delete document : \(err)")
                }else{
                    print(#function, "successfully deleted : \(deleteCourse.courseName)")
                }
            }
    }
    
    //logout
    func logout(){
        self.user = User()
        self.userList = [User]()
        self.courseList = [Course]()
    }
}
