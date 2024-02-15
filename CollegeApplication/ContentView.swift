//
//  ContentView.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/8.
//




import SwiftUI

struct ContentView: View {
    @EnvironmentObject var user : User
    @State private var selectedScreen : Int = 2
    var body: some View {
        VStack{
            TabView(selection: $selectedScreen){
                NavigationStack{
                    if user is Student{
                        StudentCoursesView().environmentObject(user as! Student)
                    } else {
                        InstructorCoursesView().environmentObject(user as! Instructor)
                    }
                }.tabItem {
                    Text("My Courses")
                    Image(systemName: "book.pages")
                }.tag(1)
                
                NavigationStack{
                    MainView().environmentObject(user)
                }.tabItem{
                    Text("Home")
                    Image(systemName: "house")
                }.tag(2)
                
                NavigationStack{
                    ProfileView().environmentObject(user)
                }                .tabItem {
                    Text("Profile")
                    Image(systemName: "person")
                }.tag(4)
                
                AboutUsView()
                    .tabItem {
                        Text("About Us")
                        Image(systemName: "info.circle")
                    }.tag(5)
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
