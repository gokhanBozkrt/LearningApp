//
//  RectangleCard.swift
//  LearningApp
//
//  Created by Gokhan Bozkurt on 10.03.2022.
//

import SwiftUI

struct RectangleCard: View {
    var colour:Color
   
    var body: some View {
        Rectangle()
           .foregroundColor(colour)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

