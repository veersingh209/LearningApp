//
//  ContentModel.swift
//  LearningApp
//
//  Created by Veer Singh on 8/25/22.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    @Published var currentModule: Module?
    
    var currentModuleIndex = 0
    var styleData: Data?
    
    init() {
        getJSONData()
        getStyleData()
    }
    
    func getJSONData() {
        
        let urlJSON = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            
            let data = try Data(contentsOf: urlJSON!)
            
            let decoder = JSONDecoder()
            let modules = try decoder.decode([Module].self, from: data)
            
            self.modules = modules
            
        } catch {
            print("ERROR! Unable to parse JSON data: \(error)")
        }
        
        
    }
    
    func getStyleData() {
        
        let styleURL = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            
            let data = try Data(contentsOf: styleURL!)
            
            self.styleData = data
            
        } catch {
            print("ERROR! Unable to parse HTML Style data: \(error)")
        }
        
    }
    
    func startingModule(_ moduleid: Int) {
        for index in 0..<modules.count {
            
            if modules[index].id == moduleid {
            
                currentModuleIndex = index
                break
            }
        }
        
        currentModule = modules[currentModuleIndex]
    }
    
}
