//
//  ContentView.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/8.
//




import SwiftUI

struct ContentView: View {
    @EnvironmentObject var fireDBHelper :FireDBHelper
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @State private var selectedScreen : Int = 3
    var body: some View {
        VStack{
            TabView(selection: $selectedScreen){
                if fireDBHelper.user is Student{
                    StudentCoursesView().environmentObject(fireDBHelper).tabItem {
                        Text("My Courses")
                        Image(systemName: "book.pages")
                    }.tag(1)
                } else {
                    InstructorCoursesView().environmentObject(fireDBHelper).tabItem {
                        Text("My Courses")
                        Image(systemName: "book.pages")
                    }.tag(2)
                }
                MainView().environmentObject(fireDBHelper).tabItem{
                    Text("Home")
                    Image(systemName: "house")
                }.tag(3)
                
                ProfileView().environmentObject(fireAuthHelper).environmentObject(fireDBHelper).tabItem {
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
    ContentView()
}
