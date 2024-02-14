//
//  NavigationBarMenu.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/12/24.
//

import SwiftUI

struct NavigationBarMenu: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Menu {
            if user is Student {
                NavigationLink(
                    destination: ProfileView(),
                    label: {
                        Text("Profile")
                    }
                )
                NavigationLink(
                    destination: MainView(),
                    label: {
                        Text("Courses")
                    }
                )
                NavigationLink(
                    destination: GradeView(),
                    label: {
                        Text("Grades")
                    }
                )
                NavigationLink(
                    destination: WelcomeScreenView(),
                    label: {
                        Text("Log out")
                    }
                )
            } else if user is Instructor {
                NavigationLink(
                    destination: ProfileView(),
                    label: {
                        Text("Profile")
                    }
                )
                NavigationLink(
                    destination: MainView(),
                    label: {
                        Text("Courses")
                    }
                )
                NavigationLink(
                    destination: GradeView(),
                    label: {
                        Text("Add New Course")
                    }
                )
                NavigationLink(
                    destination: WelcomeScreenView(),
                    label: {
                        Text("Log out")
                    }
                )
            }
        } label: {
            Image(systemName: "ellipsis.circle.fill")
        }
    }
}

#Preview {
    NavigationBarMenu()
}
