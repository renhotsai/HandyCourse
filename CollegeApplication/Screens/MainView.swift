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
                        NavigationLink(
                            destination: MainView(),
                            label: {
                                Text("Courses")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white)
                                    .cornerRadius(50.0)
                                    .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0.0, y: 16)
                                    .padding(.vertical)
                            }
                        )
                        NavigationLink(
                            destination: GradeView(),
                            label: {
                                Text("Grades")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white)
                                    .cornerRadius(50.0)
                                    .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0.0, y: 16)
                                    .padding(.vertical)
                            }
                        )
                        NavigationLink(
                            destination: WelcomeScreenView(),
                            label: {
                                Text("Log out")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white)
                                    .cornerRadius(50.0)
                                    .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0.0, y: 16)
                                    .padding(.vertical)
                            }
                        )
                    } label : {
                        Image(systemName: "ellipsis.circle.fill")

                    }
                }
            }
        }
      
    }
}

#Preview {
    MainView()
}
