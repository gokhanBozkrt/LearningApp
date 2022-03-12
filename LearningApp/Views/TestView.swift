//
//  TestView.swift
//  LearningApp
//
//  Created by Gokhan Bozkurt on 10.03.2022.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex:Int?
    @State var submitted = false
    @State var numCorrect = 0

    var body: some View {
        
       VStack {
            if model.currentQuestion != nil {
                VStack(alignment:.leading) {
                    // Question Number
                    Text("Question \(model.currentQuestionIndex + 1)  of \(model.currentModule?.test.questions.count ?? 0)")
                        .padding(.leading,20)
                    // Question
                    CodeTextView()
                        .padding(.horizontal,20)
                    // Answers
                    ScrollView {
                        VStack {
                            ForEach(0..<model.currentQuestion!.answers.count, id: \.self) { index in
                                Button {
                                    // Track the selected Index
                                    selectedAnswerIndex = index
                                    
                                } label: {
                                    ZStack {
                                        if submitted == false {
                                        RectangleCard(colour: selectedAnswerIndex == index ? .gray : .white)
                                            .frame(height: 48)
                                        } else {
                                            // Answer submitted
                                            if index == selectedAnswerIndex && index == model.currentQuestion!.correctIndex {
                                                RectangleCard(colour: .green)
                                                    .frame(height: 48)
                                            } else if index == selectedAnswerIndex && index != model.currentQuestion!.correctIndex {
                                                RectangleCard(colour: .red)
                                                    .frame(height: 48)
                                            } else if index == model.currentQuestion!.correctIndex   {
                                                // This button is the correct show green background
                                              
                                                RectangleCard(colour: .green)
                                                    .frame(height: 48)
                                            } else {
                                                RectangleCard(colour: .white)
                                                    .frame(height: 48)
                                            }
                                        }
                                        
                                        Text(model.currentQuestion!.answers[index])
                                    }
                                }.disabled(submitted)
                            }
                        }.padding()
                           // .accentColor(.black)
                    }
                    // Submit Button
                    Button {
                        // Check if answer submitted
                        if submitted == true {
                            // answer alrady submitted
                            model.nextQuestion()
                            submitted = false
                            selectedAnswerIndex = nil
                        } else {
                            // Submit the answer
                            // Change Submit state to true
                            submitted = true
                            if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                                numCorrect += 1
                            }
                        }
                      
                        
                    } label: {
                        ZStack {
                            RectangleCard(colour: .green)
                                .frame(height: 48)
                            
                            Text(buttonText)
                                .bold()
                                .foregroundColor(.white)
                              
                        }.padding()
                        // Until user selects an answer
                    }.disabled(selectedAnswerIndex == nil)
                        
                    
                }.navigationBarTitle("\(model.currentModule?.category ?? "") Test")
                   
            }
        }
        
    }
    
    var buttonText:String {
        // Check answer is submitted
        if submitted == true {
            if model.currentQuestionIndex + 1 == model.currentModule!.test.questions.count {
                return "Finish"
            } else {
                return "Next"
            }
            
        } else {
            return "Submit"
        }
    }
}



struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
