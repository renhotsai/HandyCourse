//
//  HomeView.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var fireDBHelper :FireDBHelper
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @EnvironmentObject var fireStorageHelper : FireStorageHelper
    
    @State private var selectedScreen : Int = 2
    
    @Binding var rootScreen : RootScreen

    var body: some View {
        
        VStack{
            TabView(selection: $selectedScreen){
                
                if fireDBHelper.user.role == .Student{
                    StudentCoursesView().environmentObject(fireDBHelper).tabItem {
                        Text("My Courses")
                        Image(systemName: "book.pages")
                    }.tag(1)
                } else {
                    InstructorCoursesView().environmentObject(fireDBHelper).tabItem {
                        Text("My Courses")
        
                        Image(systemName: "book.pages")
                    }.tag(1)
                }
                MainView().environmentObject(fireDBHelper).tabItem{
                    Text("Home")
                    Image(systemName: "house")
                }.tag(2)
                
                ProfileView().environmentObject(fireAuthHelper).environmentObject(fireDBHelper).environmentObject(fireStorageHelper).tabItem {
                    Text("Profile")
                    Image(systemName: "person")
                }.tag(3)
                
                AboutUsView()
                    .tabItem {
                        Text("About Us")
                        Image(systemName: "info.circle")
                    }.tag(4)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Let's learn!")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    fireAuthHelper.signOut(fireDBHelper: fireDBHelper)
                    rootScreen = .Login
                },label: {Text("Logout")})
            }
        }
    }
}

#Preview {
    ContentView()
}
