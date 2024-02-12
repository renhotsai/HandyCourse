//
//  MainView.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/9.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var user : User
    
    var body: some View {
            VStack{
                List{
                    ForEach(courses){ course in
                        NavigationLink{
                        
                        }label: {
                            Text("\(course.courseName)")
                        }//NavigationLink
                    }//ForEach
                }//List
            }//VStack
            .navigationTitle("College")
            .navigationBarBackButtonHidden()
    }
}

#Preview {
    MainView()
}
