//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Gokhan Bozkurt on 2.03.2022.
//

import SwiftUI

@main
struct LearnIos: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
