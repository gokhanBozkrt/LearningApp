//
//  ContentModel.swift
//  LearningApp
//
//  Created by Gokhan Bozkurt on 2.03.2022.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    var styleData:Data?
    
    init() {
        getLocalData()
    }
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
}
