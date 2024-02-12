//
//  ProfileView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/12/24.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var user : User
    
    var body: some View {
        Text("Welcome, \(user.username)")
                           .font(.headline)
                           .padding()
    }
}

#Preview {
    ProfileView()
}
