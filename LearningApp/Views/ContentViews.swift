//
//  ContentViews.swift
//  LearningApp
//
//  Created by Gokhan Bozkurt on 5.03.2022.
//

import SwiftUI

struct ContentViews: View {
 //   var module:Module
    @EnvironmentObject var model: ContentModel
    var body: some View {
        ScrollView {
            LazyVStack {
                // Confirm that current module set
                if model.currentModule != nil {
                    ForEach(0..<model.currentModule!.content.lessons.count) { index in
                        NavigationLink {
                            ContentDetailView()
                                .onAppear {
                                    model.beginLesson(index)
                                }
                        } label: {
                            ContentIViewRow(index: index )
                        }

                        
                       
                    
                }
            }
        } .accentColor(.black)
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
    }
}


