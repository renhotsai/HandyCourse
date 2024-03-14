//
//  FireStorageHelper.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/3/13.
//

import Foundation
import FirebaseStorage
import UIKit

class FireStorageHelper:ObservableObject{
    private let storageRef : StorageReference
    private static var shared : FireStorageHelper?
    
    
    
    init(storageRef : StorageReference){
        self.storageRef = storageRef
    }
    
    static func getInstance() -> FireStorageHelper{
        if (shared == nil){
            shared = FireStorageHelper(storageRef: Storage.storage().reference())
        }
        
        return shared!
    }
    
    func uploadImage(image: UIImage, imageName: String, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"])))
            return
        }
        
        let imageRef = storageRef.child("images/\(imageName)")
        imageRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard let _ = metadata else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
                }
                return
            }
            
            imageRef.downloadURL { (url, error) in
                if let downloadURL = url {
                    completion(.success(downloadURL))
                } else {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
                    }
                }
            }
        }
    }
    
    func getImageFromFirebaseStorage(imageName: String, completion: @escaping (UIImage?) -> Void) {
        let imageRef = storageRef.child("images/\(imageName)")
        
        // Fetch image data from Firebase Storage
        imageRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error getting image from Firebase Storage: \(error.localizedDescription)")
                completion(nil)
            } else {
                if let imageData = data, let image = UIImage(data: imageData) {
                    // Convert image data to UIImage
                    completion(image)
                } else {
                    print("Error: Unable to convert image data to UIImage")
                    completion(nil)
                }
            }
        }
    }
}
