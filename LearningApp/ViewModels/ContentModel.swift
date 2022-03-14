//
//  ContentModel.swift
//  LearningApp
//
//  Created by Gokhan Bozkurt on 2.03.2022.
//

import Foundation

class ContentModel: ObservableObject {
    // List of modules
    @Published var modules = [Module]()
    // Current module
    @Published var currentModule:Module?
    var currentModuleIndex = 0
    // Current Lesson
    @Published var currentLesson:Lesson?
    var currentLessonIndex = 0
    // Current Question
    @Published var currentQuestion:Question?
    var currentQuestionIndex = 0
    // Cureent Lesson Explanation
    @Published var codeText = NSAttributedString()
    var styleData:Data?
    
    // Current Selected Content and test
    @Published var currentContentSelected:Int?
    @Published var currentTestSelected:Int?
    
    init() {
        getLocalData()
        getRemoteData()
    }
    // Mark:Data Methods
    func getLocalData() {
        // get url path to the json file
       //   let pathString = Bundle.main.path(forResource: "recipes", ofType: "json")
       let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
       
        do {
           let jsonData = try Data(contentsOf: jsonUrl!)
           let jsonDecoder = JSONDecoder()
          let modules = try jsonDecoder.decode([Module].self, from: jsonData)
          // Assing parsed modeles to modules property
           self.modules = modules
       }
       catch {
          print(error)
       }
       // Parse the style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            let styleData = try Data(contentsOf: styleUrl!)
            self.styleData = styleData
        }
        catch {
            print("error")
        }
   }
    // Remote Data
    
    func getRemoteData() {
        // String path
        let urlString = "https://gokhanbozkrt.github.io/LearningApp-data2/data2.json"
        
        // Create Url object
        let url = URL(string: urlString)
        guard url != nil else {
            // Couldnt create url
            return
        }
        // Create url request object
        let request = URLRequest(url: url!)
        // Get the session kick off the task
        let session = URLSession.shared
       let dataTask = session.dataTask(with: request) { data, response, error in
            // Check if there's in an error
           guard error == nil else {
               return
           }
            // Handle the response, Create Json Decoder
           
           
          // Decode
           do {
               let decoder = JSONDecoder()
              let moduleList = try decoder.decode([Module].self, from: data!)
               // Append parsed modules into property
               self.modules += moduleList
           }
           catch {
               print(error)
           }
            
        }
        // Kick off the data task
        dataTask.resume()
        
        
    }
    
    // MARK:Module Navigation Methods
    func beginModule(_ moduleId:Int) {
        // Find find the index for this module id
        for index in 0..<modules.count {
            if modules[index].id == moduleId {
                // Found Matching Module
                currentModuleIndex = index
                break
            }
        }
        
        // Set currrent module
        currentModule = modules[currentModuleIndex]
    }
     // MARK: Lesson Id
    func beginLesson(_ lessonIndex:Int) {
        // Find find the index for this lesson id
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        } else {
            currentLessonIndex = 0
        }
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
         codeText = addStyling(currentLesson!.explanation)
    }
    
    func hasNextLesson() -> Bool {
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    // MARK:Question
    func beginTest(_ moduleId:Int) {
        // Set the current module
        beginModule(moduleId)
        // Set the current question
        currentQuestionIndex = 0
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            }
        // Set the question content as well
        codeText = addStyling(currentQuestion!.content)
    }
    
    // MARK: Next Question
    func nextQuestion() {
        // Advance the question index
        currentQuestionIndex += 1
        // Check that it is within the range of questions
        if currentQuestionIndex < currentModule!.test.questions.count {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        } else {
            // if not then reset
            currentQuestionIndex = 0
            currentQuestion = nil
        }
       
    }
    
    // Next lesson
    func nextLesson() {
        // Advance Lesson index
        currentLessonIndex += 1
        // Check that it is within the range
        if currentLessonIndex < currentModule!.content.lessons.count {
            // Set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
        } else {
            // Reset the currentlesson index
            currentLessonIndex = 0
            currentLesson = nil
        }
        codeText = addStyling(currentLesson!.explanation)
        
    }
   // MARK: Code Styling
    private func addStyling(_ htmlString:String) -> NSAttributedString {
        var resultString = NSAttributedString()
        var data = Data()
        // Add Styling Data
        if styleData != nil {
            data.append(self.styleData!)
        }
        // Add html data
        data.append(Data(htmlString.utf8))
        // Convert to attributed string
       // Technique 1
       /*
        do {
             let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
               
                resultString = attributedString
            
        }
        catch {
            print("Coulndnt turn html into attributed value")
        }
        */
        // Technique 2
        
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            resultString = attributedString
        }
       
        return resultString
    }
        
}
