//
//  InstructorContentView.swift
//  CollegeApplication
//
//  Created by 이현성 on 3/13/24.
//

import SwiftUI

struct InstructorContentView: View {
    @EnvironmentObject var fireDBHelper: FireDBHelper
    @State private var contents: [CourseContents] = [] // State to hold the fetched contents
    var course: Course
    
    var body: some View {
        VStack {
            Text("Course Content")
                .font(.title)
                .padding()
            
            // Iterate over the contents array
            List(contents) { content in
//                NavigationLink(destination: VideoDetailView(videoURL: URL(string: content.videoURL)!)) {
//                    HStack(spacing: 8) {
//                        Image(systemName: "checkmark")
//                            .foregroundColor(content.watched ? .green : .black) // Change color based on watched status
//                            .padding(.trailing, 4)
//                        Text(content.title)
//                            .font(.headline)
//                    }
//                    .padding()
//                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            NavigationLink(destination: AddCourseContentView(course: course).environmentObject(fireDBHelper)) {
                Text("Add Content")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green) // Changed to light green
                    .cornerRadius(10)
            }
            .padding()
        }
        .onAppear {
            fireDBHelper.getContentsForCourse(courseID: course.id ?? "") { fetchedContents in
                // Update the contents array with fetched contents
                self.contents = fetchedContents
            }
        }
    }
}

struct InstructorContentView_Previews: PreviewProvider {
    static var previews: some View {
        InstructorContentView(course: Course())
    }
}
