//
//  ContentView.swift
//  LearningApp
//
//  Created by Gokhan Bozkurt on 2.03.2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: ContentModel
 
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
