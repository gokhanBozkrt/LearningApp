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
        // Description
            CodeTextView()
        
        // Show Next Lesson Button If there is next lesson
            if model.hasNextLesson() {
                Button {
                    model.nextLesson()
                } label: {
                    ZStack {
                        RectangleCard(colour: .green)
                            .frame(height: 48)
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
            }
            else {
                // Show the complete button
                Button {
                    model.currentContentSelected = nil
                } label: {
                    ZStack {
                        RectangleCard(colour: .green)
                            .frame(height: 48)
                        Text("Complete")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
            }

    }
        .navigationBarTitle(lesson?.title ?? "")
        .padding()
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
