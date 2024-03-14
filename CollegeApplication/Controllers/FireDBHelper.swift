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
    private let FIELD_VIDEOWATCHED: String = "videoWatched"
    
    @Published var user : User = User()
    @Published var userList : [User] = []
 
    private let COLLECTION_COURSES : String = "courses"
    private let FIELD_COURSENAME :String = "courseName"
    private let FIELD_COURSEDESC : String = "courseDesc"
    private let FIELD_INSTRUCTOR : String="instructorList"
    private let FIELD_STUDENTLIMIT :String = "studentLimit"
    private let FIELD_STARTDATE :String = "startDate"
    private let FIELD_ENDDATE : String = "endDate"
    private let FIELD_COURSEPRICE : String = "coursePrice"
    private let FIELD_COURSECATEGORIES : String = "courseCategories"
    private let FIELD_COURSEIMAGENAME : String = "courseImageName"
    
    private let COLLECTION_STUDENTGRADES :String = "studentGrades"
    private let FIELD_GRADE : String = "grade"
    
    private let COLLECTION_CONTENTS : String = "contents"
    private let FIELD_CONTENTTITLE: String = "contentTitle"
    private let FIELD_CONTENTDESCRIPTION: String = "contentDescription"
    private let FIELD_VIDEOURL: String = "videoURL"

    
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

    func getInstructor(userId: String, completion: @escaping (User?) -> Void) {
        db.collection(COLLECTION_USERS).document(userId).getDocument { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print(#function, "Unable to retrieve data from Firestore : \(error!)")
                completion(nil)
                return
            }
            do {
                if document.exists {
                    let user = try document.data(as: User.self)
                    completion(user)
                } else {
                    print(#function, "Document does not exist for user ID: \(userId)")
                    completion(nil)
                }
            } catch {
                print(#function, "Error decoding user data: \(error)")
                completion(nil)
            }
        }
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
    
    func updateUserImage(user:User, image:UIImage? = nil, fireStorageHelper: FireStorageHelper? = nil){
        if image != nil {
            fireStorageHelper?.uploadImage(image: image!, imageName: user.name){ result in
                switch result {
                case .success(let url):
                    user.imageName = url.absoluteString
                    self.updateUser(user: user)
                case .failure(let error):
                    print("Error uploading image: \(error.localizedDescription)")
                }
            }
        }
    }
    
    //user marked as watched content
    func markContentAsWatched(userId: String, courseId: String, contentId: String) {
        let userRef = db.collection(COLLECTION_USERS).document(userId)
        
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var userData = document.data() ?? [:]
                var watchedContents = userData["watchedContents"] as? [String: [String]] ?? [:]
                
                // Check if the courseId exists in watchedContents
                if watchedContents[courseId] != nil {
                    // If yes, append the contentId to the existing array
                    if !watchedContents[courseId]!.contains(contentId) {
                        watchedContents[courseId]?.append(contentId)
                    }
                } else {
                    // If not, create a new array with the contentId and associate it with the courseId
                    watchedContents[courseId] = [contentId]
                }
                
                // Update the watchedContents field in the user document
                userData["watchedContents"] = watchedContents
                
                // Update the user document in Firestore
                userRef.setData(userData) { error in
                    if let error = error {
                        print("Error updating document: \(error)")
                    } else {
                        print("Document successfully updated")
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }

    //delete watched content   
    func deleteWatchedContent(courseId: String, contentId: String) {
        let usersRef = db.collection(COLLECTION_USERS)
        
        // Get all users
        usersRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    let userId = document.documentID
                    self.deleteWatchedContentForUser(userId: userId, courseId: courseId, contentId: contentId)
                }
            }
        }
    }
    
    private func deleteWatchedContentForUser(userId: String, courseId: String, contentId: String) {
        let userRef = db.collection(COLLECTION_USERS).document(userId)
        
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var userData = document.data() ?? [:]
                var watchedContents = userData["watchedContents"] as? [String: [String]] ?? [:]
                
                // Check if the courseId exists in watchedContents
                if var contentIds = watchedContents[courseId] {
                    // Remove the specified contentId from the array
                    contentIds.removeAll { $0 == contentId }
                    
                    // Update the watchedContents dictionary
                    watchedContents[courseId] = contentIds
                    
                    // Update the userData dictionary
                    userData["watchedContents"] = watchedContents
                    
                    // Update the user document in Firestore
                    userRef.setData(userData) { error in
                        if let error = error {
                            print("Error updating document: \(error)")
                        } else {
                            print("Watched content successfully deleted for user \(userId)")
                        }
                    }
                }
            } else {
                print("Document does not exist for user \(userId)")
            }
        }
    }
    
    //insert Course
    func insertCourse(course : Course){
        do{
            let newcourse = try self.db
                .collection(COLLECTION_COURSES)
                .addDocument(from: course)
            let user = self.user
            user.addCourse(courseId: newcourse.documentID)
            self.updateUser(user: user)
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
                                self.getStudentGrade(course: course)
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
                            self.objectWillChange.send()
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
                FIELD_COURSEPRICE: course.coursePrice,
                FIELD_COURSECATEGORIES: course.courseCategories.rawValue,
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
        print("Course ID is: \(courseId), student ID is : \(studentId)")
        do{
            try self.db
                .collection(COLLECTION_COURSES).document(courseId)
                .collection(COLLECTION_STUDENTGRADES).document(studentId).setData(from: StudentGrade(studentId: studentId))
        }catch let err as NSError{
            print(#function, "Unable to add document to firestore : \(err)")
        }
    }
    
    //updateStudentGrade
    func updateStudentCourse(courseId:String, studentId:String, grade:Int){
        self.db.collection(COLLECTION_COURSES).document(courseId)
            .collection(COLLECTION_STUDENTGRADES).document(studentId)
            .updateData([
                FIELD_GRADE : grade
            ]){ error in
                if let err = error{
                    print(#function, "Unable to update document : \(err)")
                }else{
                    print(#function, "successfully updated : \(courseId)")
                }
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
    
    //add content 
    func addContent(content: CourseContents, courseId: String) {
        do {
            try self.db
                .collection(COLLECTION_COURSES)
                .document(courseId)
                .collection(COLLECTION_CONTENTS)
                .addDocument(from: content)
        } catch let err as NSError {
            print(#function, "Unable to add document to firestore : \(err)")
        }
    }

    //get contents
    func getContentsForCourse(courseID: String, completion: @escaping ([CourseContents]) -> Void) {
        db.collection(COLLECTION_COURSES)
            .document(courseID)
            .collection(COLLECTION_CONTENTS)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                    completion([])
                } else {
                    var contents: [CourseContents] = []
                    
                    for document in querySnapshot!.documents {
                        do {
                            let content = try document.data(as: CourseContents.self)
                            contents.append(content)                            
                        } catch {
                            print("Error decoding content data: \(error)")
                        }
                    }
                    
                    // Return the contents array through completion handler
                    completion(contents)
                }
            }
    }

    func deleteContent(content: CourseContents, course: Course) {
        self.db.collection(COLLECTION_COURSES)
            .document(course.id!)
            .collection(COLLECTION_CONTENTS)
            .document(content.id!) // Assuming content.id exists and uniquely identifies the content
            .delete { error in
                if let error = error {
                    print(#function, "Unable to delete content document: \(error)")
                } else {
                    print(#function, "Successfully deleted content: \(content.title)")
                }
            }
    }
    //signin
    func signin(userId : String){
        self.getUser(userId: userId)
        self.getAllUsers()
        self.getAllCourses()
        print(#function, "courseList: \(self.courseList)")
    }
    
    //logout
    func logout(){
        self.user = User()
        self.userList = [User]()
        self.courseList = [Course]()
    }
}
