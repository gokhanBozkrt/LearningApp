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
                if model.curentModule != nil {
                    ForEach(0..<model.curentModule!.content.lessons.count) { index in
                        ContentIViewRow(index: index )
                    
                }
            }
        }
            .padding()
            .navigationTitle("Learn \(model.curentModule?.category ?? "")")
        }
    }
}


