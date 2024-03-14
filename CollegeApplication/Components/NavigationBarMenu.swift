//
//  NavigationBarMenu.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/12/24.
//

import SwiftUI

struct NavigationBarMenu: View {
//    @EnvironmentObject var user: User
    
    var body: some View {
        Menu {
            NavigationLink(
                destination: ContentView().onAppear {
                    // Clear email and password from UserDefaults upon navigation to ContentView
                    UserDefaults.standard.removeObject(forKey: "email")
                    UserDefaults.standard.removeObject(forKey: "password")
                },
                label: {
                    Text("Log out")
                }
            ).onTapGesture {
                UserDefaults.standard.removeObject(forKey: "currUser")
            }
        } label: {
            Image(systemName: "ellipsis.circle.fill")
        }
    }
}

#Preview {
    NavigationBarMenu()
}
