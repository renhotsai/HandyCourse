//
//  ContentView.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/8.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var user : User
    @State private var selectedSreen : Int? = 2
    var body: some View {
        VStack{
            TabView(selection: $selectedSreen){
                if user is Student{
                    StudentCoursesView().environmentObject(user as! Student).tabItem {
                        Text("My Courses")
                        Image(systemName: "book.pages")
                    }.tag(1)
                } else {
                    InstructorCoursesView().environmentObject(user as! Instructor).tabItem {
                        Text("My Courses")
                        Image(systemName: "book.pages")
                    }.tag(2)
                }
                MainView().environmentObject(user).tabItem{
                    Text("Home")
                    Image(systemName: "house")
                }.tag(3)
                
                ProfileView().environmentObject(user).tabItem {
                    Text("Profile")
                    Image(systemName: "person")
                }.tag(4)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Let's learn!")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationBarMenu()
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(User())
}
