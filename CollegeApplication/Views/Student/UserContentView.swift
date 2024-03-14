import SwiftUI

struct UserContentView: View {
    @EnvironmentObject var fireDBHelper: FireDBHelper
    @State private var contents: [CourseContents] = [] // State to hold the fetched contents
    @State private var user: User = User()

    var course: Course
    
    var body: some View {

        VStack {
            VStack {
                HStack {
                    Text("Course Progression:")
                        .font(.headline)
                                                    
                    Text("\(Int(calculateCompletionPercentage()))%")
                    Spacer()
                }
                                
                ProgressBar(value: calculateCompletionPercentage(), color: .blue)
            }
            .frame(height: 30)

            Text("Course Content")
                .font(.title)
                .padding()
      
            // Iterate over the contents array
            List(contents) { content in
                NavigationLink(destination: VideoDetailView(videoURL: URL(string: content.videoURL)!, markAsWatched: {
                    fireDBHelper.markContentAsWatched(userId: user.id, courseId: course.id!, contentId: content.id!)
                    user.markContentAsWatched(courseId: course.id!, contentId: content.id!)
                })) {
                    HStack(spacing: 8) {
                        if user.watchedContents[course.id ?? ""]?.contains(content.id ?? "") ?? false {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue) // Blue color if content is watched
                                .padding(.trailing, 4)
                        } else {
                            Image(systemName: "checkmark")
                                .foregroundColor(.black) // Black color if content is not watched
                                .padding(.trailing, 4)
                        }
                        Text(content.title)
                            .font(.headline)
                    }
                    .padding()
                }
            }
            .padding(.bottom, 30)
            .padding(.horizontal)

     
            

        }
        .onAppear {
            self.user = fireDBHelper.user
            fireDBHelper.getContentsForCourse(courseID: course.id ?? "") { fetchedContents in
                // Update the contents array with fetched contents
                self.contents = fetchedContents
            }
            
        }
        
    }
    
    // Function to calculate the completion percentage of the course
    private func calculateCompletionPercentage() -> Double {
        guard !contents.isEmpty else {
            return 0 // Return 0 if there are no contents
        }
        
        let totalContents = contents.count
        let watchedContents = user.watchedContents[course.id ?? ""]?.count ?? 0
        
        return Double(watchedContents) / Double(totalContents) * 100
    }
}

struct UserContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserContentView(course: Course())
    }
}

// ProgressBar View
struct ProgressBar: View {
    var value: Double
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.secondary.opacity(0.3))
                    .frame(width: geometry.size.width, height: 10)
                    .cornerRadius(5)
                
                Rectangle()
                    .foregroundColor(self.color)
                    .frame(width: min(CGFloat(self.value) / 100 * geometry.size.width, geometry.size.width), height: 10)
                    .cornerRadius(5)
            }
        }
    }
}
