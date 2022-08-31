//
//  TestView.swift
//  LearningApp
//
//  Created by Veer Singh on 8/31/22.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        if model.currentQuestion != nil {
            
            VStack {
                
                Text("Question \(model.currentTestIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                
                UITextViews()
                
            }
            .navigationTitle("\(model.currentModule?.category ?? "") Test")
            
        } else {
            ProgressView()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
