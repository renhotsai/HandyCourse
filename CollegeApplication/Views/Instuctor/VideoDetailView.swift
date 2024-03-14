//
//  VideoDetailView.swift
//  CollegeApplication
//
//  Created by 이현성 on 3/13/24.
//

import SwiftUI
import AVKit

struct VideoDetailView: View {
    let videoURL: URL
    let markAsWatched: () -> Void
    var body: some View {
        VideoPlayer(player: AVPlayer(url: videoURL))
            .edgesIgnoringSafeArea(.all)
            .onAppear() {
                self.markAsWatched()
            }
    }
}

struct VideoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VideoDetailView(videoURL: URL(string: "YOUR_VIDEO_URL_HERE")!, markAsWatched: {})
    }
}
