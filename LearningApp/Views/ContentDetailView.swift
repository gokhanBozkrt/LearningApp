//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Gokhan Bozkurt on 6.03.2022.
//

import SwiftUI
import AVKit
struct ContentDetailView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        VStack {
        if url != nil {
            VideoPlayer(player: AVPlayer(url: url!))
                .cornerRadius(10)
        }
        // TODO: Description
        
        // Show Next Lesson Button If there is next lesson
            if model.hasNextLesson() {
                Button {
                    model.nextLesson()
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(height: 48)
                            .foregroundColor(.green)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
            }

    }
        .padding()
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
