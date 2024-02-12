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
                    
                    ForEach(courses){ course in
                        NavigationLink{
                            
                        }label: {
                            Text("\(course.courseName)")
                        }//NavigationLink
          
                    }//ForEach
                }//List
            }//VStack
            .navigationTitle("Let's learn!")
            .navigationBarTitleDisplayMode(.inline)

            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        if let student = user as? Student {
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
                        } else if let instructor = user as? Instructor {
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
            
                    } label : {
                        Image(systemName: "ellipsis.circle.fill")
                    }
                }
            }
    
         
           
        }.navigationBarBackButtonHidden(true)
      
    }
}



#Preview {
    MainView()
}
