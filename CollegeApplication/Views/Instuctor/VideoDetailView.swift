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
    
    var body: some View {
        VideoPlayer(player: AVPlayer(url: videoURL))
            .edgesIgnoringSafeArea(.all)
    }
}

struct VideoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VideoDetailView(videoURL: URL(string: "YOUR_VIDEO_URL_HERE")!)
    }
}
