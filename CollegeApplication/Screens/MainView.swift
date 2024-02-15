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
                if user is Instructor{
                    let instructor = user as! Instructor
                    ForEach(instructor.courseList){ course in
                        NavigationLink{
                            DetailView(course: course).environmentObject(user)
                        } label: {
                            Text("\(course.courseName)")
                        }//NavigationLink
                    }//ForEach
                } else {
                    ForEach(courses){ course in
                        NavigationLink{
                            DetailView(course: course).environmentObject(user)
                        }label: {
                            Text("\(course.courseName)")
                        }//NavigationLink
                    }//ForEach
                }//if
            }//List
        }//VStack
    }
}



#Preview {
    MainView().environmentObject(User())
}
