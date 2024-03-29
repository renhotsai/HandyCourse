//
//  InstructorCourseInfoView.swift
//  CollegeApplication
//
//  Created by 이현성 on 2/14/24.
//

import SwiftUI

struct InstructorCourseInfoView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showAlert = false
    
    var course: Course

    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .center, spacing: 20) {
                if let imageName = course.courseImageName {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .clipped()
                }
                Text("Description: \(course.courseDesc)")
                    .font(.headline)
                HStack {
                    Text("Start Date:")
                        .font(.headline)
                        .padding(.trailing, 10)
                    Text(formattedDate(course.startDate))
                        .font(.subheadline)
                        .padding(10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                HStack {
                    Text("End Date:")
                        .font(.headline)
                        .padding(.trailing, 10)
                    Text(formattedDate(course.endDate))
                        .font(.subheadline)
                        .padding(10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                
                Spacer()
                
                NavigationLink(destination: EditCourseView(course: course).environmentObject(fireDBHelper)) {
                    Text("Update Course")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green) // Changed to light green
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
            .navigationBarTitle(course.courseName)
        }
    }

    func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
}


#Preview {
    InstructorCourseInfoView(course: Course())
}
