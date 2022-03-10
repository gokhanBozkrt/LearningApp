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
    // Cureent Lesson Explanation
    @Published var lessonDescription = NSAttributedString()
    var styleData:Data?
    
    // Current Selected Content and test
    @Published var currentContentSelected:Int?
    init() {
        getLocalData()
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
         lessonDescription = addStyling(currentLesson!.explanation)
    }
    
    func hasNextLesson() -> Bool {
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
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
            // Reset the currenlesson index
            currentLessonIndex = 0
            currentLesson = nil
        }
        lessonDescription = addStyling(currentLesson!.explanation)
        
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
