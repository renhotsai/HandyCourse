//
//  MainView.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/9.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper

    var body: some View {
        VStack {
            List {
                ForEach(fireDBHelper.courseList) { course in
                    NavigationLink(destination: DetailView(course: course).environmentObject(fireDBHelper)) {
                        VStack(alignment: .leading) {
                            if let imageName = course.courseImageName {
                                Image(imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: .infinity, maxHeight: 200)
                                    .clipped()
                            } else {
                                Image("default")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: .infinity, maxHeight: 200)
                                    .clipped()
                            }
                            HStack {
                                Text(course.courseName)
                                    .font(.headline)
                                Spacer()
                                Text("\(course.studentGrades.count)/\(course.studentLimit)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            HStack {
                                Text("Duration: \(formattedDate(course.startDate)) ~  \(formattedDate(course.endDate))")

                            }
                           
                        }
                        .padding(.vertical)
                    }
                }
            }
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd" // Format: Year.Month.Day
        return dateFormatter.string(from: date)
    }
}






