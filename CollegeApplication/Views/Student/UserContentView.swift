//
//  UserContentView.swift
//  CollegeApplication
//
//  Created by 이현성 on 3/13/24.
//

import SwiftUI

struct UserContentView: View {
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
                NavigationLink(destination: VideoDetailView(videoURL: URL(string: content.videoURL)!)) {
                    HStack(spacing: 8) {
                        Image(systemName: "doc.text")
                            .padding(.trailing, 4)
                        Text(content.title)
                            .font(.headline)
                    }
                    .padding()
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .onAppear {
            fireDBHelper.getContentsForCourse(courseID: course.id ?? "") { fetchedContents in
                print("Course ID: " + course.id!)
                // Update the contents array with fetched contents
                self.contents = fetchedContents
            }
        }
    }
}

struct UserContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserContentView(course: Course())
    }
}
