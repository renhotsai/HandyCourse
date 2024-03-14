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

            List {
                ForEach(contents) { content in
                    NavigationLink(destination: VideoDetailView(videoURL: URL(string: content.videoURL)!, markAsWatched: {})) {
                        HStack(spacing: 8) {
                            Image(systemName: "checkmark")
                                .foregroundColor(content.watched ? .green : .black)
                                .padding(.trailing, 4)
                            Text(content.title)
                                .font(.headline)
                        }
                        .padding()
                    }
                }
                .onDelete { indexSet in
                    // Loop through the index set and delete each content
                    for index in indexSet {
                        let contentToDelete = contents[index]
                        if let courseId = self.course.id {
                            fireDBHelper.deleteContent(content: contentToDelete, course: course)
                          
                            fireDBHelper.deleteWatchedContent(courseId: courseId, contentId: contentToDelete.id!)
                            // Remove the deleted content from the local array
                            self.contents.remove(at: index)
                        }
                    }
                }

            }
            .padding(.horizontal)
            
            Spacer()
            
            NavigationLink(destination: AddCourseContentView(course: course).environmentObject(fireDBHelper)) {
                Text("Add Content")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
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
