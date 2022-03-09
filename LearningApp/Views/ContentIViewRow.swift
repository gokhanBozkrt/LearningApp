//
//  ContentIViewRow.swift
//  LearningApp
//
//  Created by Gokhan Bozkurt on 5.03.2022.
//

import SwiftUI

struct ContentIViewRow: View {
    @EnvironmentObject var model: ContentModel
    var index:Int
    
    var body: some View {
        let lesson = model.currentModule!.content.lessons[index]
        // Lesson Card
        ZStack(alignment:.leading) {
        Rectangle()
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .frame(height: 66)
        HStack(spacing:30) {
            Text("\(index + 1)")
                .bold()
            VStack(alignment:.leading,spacing: 5) {
                Text(lesson.title)
                    .bold()
                Text(lesson.duration)
            }
        }.padding()
    }
        .padding(.bottom,5)
    }
}


