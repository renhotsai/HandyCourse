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
                   NavigationBarMenu()
                }
            }                    
        }.navigationBarBackButtonHidden(true)
      
    }
}



#Preview {
    MainView()
}
