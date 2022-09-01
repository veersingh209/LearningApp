//
//  TestView-Results.swift
//  LearningApp
//
//  Created by Veer Singh on 8/31/22.
//

import SwiftUI

struct TestView_Results: View {
    
    @EnvironmentObject var model: ContentModel
    
    var numberOfCorrectAnswers: Int
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Text(mainHeading)
                .font(.title)
                .bold()
            
            Spacer()
            
            Text("Result:")
            HStack(spacing: 0.0) {
                Text("\(numberOfCorrectAnswers)")
                    .bold()
                Text(" out of ")
                Text("\(model.currentModule?.test.questions.count ?? 0) ")
                    .bold()
                Text("questions")
            }
            
            Spacer()
            
            Button {
                model.selectedTest = nil
            } label: {
                CustomButton(
                    buttonText: "Complete",
                    buttonColor: .green,
                    buttonTextColor: .white
                )
            }

            
        }
        .padding()
        .navigationTitle("\(model.currentModule?.category ?? "") Test Results")
        
    }
}

extension TestView_Results {
    
    var mainHeading: String {
        
        guard model.currentModule != nil else {
            return " "
        }
        
        let percentageCorrect = Double(numberOfCorrectAnswers)/Double(model.currentModule!.test.questions.count)
        
        if percentageCorrect > 0.9 {
            return "Hooray!!!"
        }
        if percentageCorrect > 0.8 {
            return "Almost Perfect!"
        }
        if percentageCorrect > 0.7 {
            return "Stellar Work"
        }
        if percentageCorrect > 0.6 {
            return "Geat!!"
        }
        if percentageCorrect > 0.5 {
            return "Good job!"
        }
        if percentageCorrect > 0.3 {
            return "Nice"
        }
        else {
            return "Continue learning!"
        }
        
    }
    
}

struct TestView_Results_Previews: PreviewProvider {
    static var previews: some View {
        TestView_Results(numberOfCorrectAnswers: 3)
            .environmentObject(ContentModel())
    }
}
