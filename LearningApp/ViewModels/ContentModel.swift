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
    @Published var currentLesson: Lessons?
    @Published var currentQuestion: Questions?
    
    @Published var text = NSAttributedString()
    @Published var selectedContent: Int?
    @Published var selectedTest: Int?
    
    var currentModuleIndex = 0
    var currentLessonIndex = 0
    var currentTestIndex = 0
    var styleData: Data?
    
    init() {
        getJSONDataLocal()
        getStyleData()
        
        getJSONDataRemote()
    }
    
    func getJSONDataLocal() {
        
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
    
    func getJSONDataRemote() {
        
        let remoteUrlJSON = Constants.hostedVideoUrl + "data2.json"
        
        let url = URL(string: remoteUrlJSON)
        
        guard url != nil else {
            print("ERROR! Unable to fetch remote URL")
            return
        }
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                print("ERROR! Unable decode remote JSON datsa")
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                
                let modules = try decoder.decode([Module].self, from: data!)
                
                // use main thread
                DispatchQueue.main.async {
                    self.modules += modules
                }

            } catch {
                print("ERROR! Unable to parse remote JSON data")
            }
        }
        dataTask.resume()
        
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
    
    func startLesson(_ lessonIndex:Int) {
        
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        } else {
            currentLessonIndex = 0
        }
        
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        text = textStyling(currentLesson!.explanation)
    }
    
    func hasNextLesson() -> Bool {
        guard currentModule != nil else {
            return false
        }
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    
    func nextLesson() {
        
        currentLessonIndex += 1
        
        if currentLessonIndex < currentModule!.content.lessons.count {
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            text = textStyling(currentLesson!.explanation)
        } else {
            currentLessonIndex = 0
            currentLesson = nil
        }
        
    }
    
    func startTest(_ moduleId:Int) {
        
        startingModule(moduleId)
        
        currentTestIndex = 0
        
        if currentModule?.test.questions.count ?? 0  > 0 {
            currentQuestion = currentModule!.test.questions[currentTestIndex]
            
            text = textStyling(currentQuestion!.content)
        }
    }
    
    func nextTestQuestion() {
        
        currentTestIndex += 1
        
        if currentTestIndex < currentModule!.test.questions.count {
            
            currentQuestion = currentModule!.test.questions[currentTestIndex]
            text = textStyling(currentQuestion!.content)
            
        } else {
            currentTestIndex = 0
            currentQuestion = nil
        }
        
    }
    
    private func textStyling(_ htmlString: String) -> NSAttributedString {
        
        var finalString = NSAttributedString()
        var data = Data()
        
        if styleData != nil {
            data.append(styleData!)
        }
        
        data.append(Data(htmlString.utf8))
        
        
        do {
            let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            
            finalString = attributedString
            
        } catch {
            print("Error: Unable to create attributed string for lesson description")
        }
        
        return finalString
    }
    
}
