//
//  CollegeApplicationApp.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/8.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

@main
struct CollegeApplicationApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
