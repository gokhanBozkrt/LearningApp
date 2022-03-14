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
        
        NavigationView {
            VStack(alignment:.leading) {
                Text("What do you want to do today?")
                    .padding(.leading,20)
                
                ScrollView {
                    LazyVStack {
                        ForEach(model.modules) { module in
                            VStack(spacing:20){
                                NavigationLink(tag: module.id, selection: $model.currentContentSelected )
                                {
                                    ContentViews().onAppear {
                                        model.beginModule(module.id)
                                     //   print(model.currentContentSelected)
                                    }
                                } label: {
                                    // Learning Card
                                    HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                }
                                
                                NavigationLink(tag: module.id, selection: $model.currentTestSelected) {
                                    TestView().onAppear() {
                                        model.beginTest(module.id)
                                    }
                                } label: {
                                    // Test Card
                                    HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: "\(module.test.questions.count) Questions", time: module.test.time)
                                }
                                
                                
                            }
                            .padding(.bottom,10)
                            
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
            } //.background(Color.indigo)
              .navigationTitle("Get Started")
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
            .previewInterfaceOrientation(.portrait)
        
    }
}


