//
//  AboutUsView.swift
//  CollegeApplication
//
//  Created by Aman  Chahal on 2/15/24.
//

import SwiftUI

struct AboutUsView : View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("About Us")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 10)
                
                // Online learning image
                Image("online_learning")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom, 10)
                
                Text("Welcome to Handy Course!")
                    .font(.title)
                
                Text("Our app is designed to help students and instructors explore, enroll in, and manage courses conveniently.")
                    .font(.body)
                
                Divider()
                
                Group {
                    AboutUsDetail(title: "Address", value: "160 Kendal Ave, Toronto, ON, Canada")
                    AboutUsDetail(title: "Phone", value: "+1 (437) 477-6201")
                    AboutUsDetail(title: "Email", value: "contact@handycoursegbc.ca")
                }
                       

                NavigationLink(destination: ContactView()) {
                    Text("Contact Us")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
        }
    }
}

struct AboutUsDetail: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            
            Text(value)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    AboutUsView()
}
