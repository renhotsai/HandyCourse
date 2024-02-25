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
            NavigationLink(
                destination: WelcomeScreenView(),
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
