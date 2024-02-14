//
//  MainView.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/9.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var user : User
    
    @State private var linkSelection : Int? = nil
   
  
    var body: some View {
     
        NavigationStack {
    
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
            .navigationTitle("Let's learn!")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                   NavigationBarMenu()
                }
            }                    
        }.navigationBarBackButtonHidden(true)
      
    }
}



#Preview {
    MainView()
}
