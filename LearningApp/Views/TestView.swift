//
//  TestView.swift
//  LearningApp
//
//  Created by Veer Singh on 8/31/22.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model:ContentModel
    
    @State var selectedAnswer: Int?
    @State var answerSubmitted = false
    @State var correctAnswerCount = 0
    
    var body: some View {
        
        if model.currentQuestion != nil {
            
            VStack(alignment: .leading) {
                
                // Question count
                HStack(spacing: 0.0) {
                    Text("Question ")
                    Text("\(model.currentTestIndex + 1)")
                        .bold()
                    Text(" of ")
                    Text("\(model.currentModule?.test.questions.count ?? 0)")
                        .bold()
                }
                
                // Question
                UITextViews()
                
                // Question answers
                ScrollView {
                    
                    VStack {
                        
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self) { index in
                            
                            ZStack {
                                
                                Button {
                                    selectedAnswer = index
                                } label: {
                                    ZStack {
                                        
                                        // No answer submitted
                                        if !answerSubmitted {
                                            CustomButton(
                                                buttonText: model.currentQuestion!.answers[index],
                                                buttonColor: (index == selectedAnswer ? .gray : .white),
                                                buttonTextColor: (answerSubmitted && index != selectedAnswer ? .gray : .black)
                                            )
                                        }
                                        else {
                                            // Correct answer submitted
                                            if index == selectedAnswer &&
                                                index == model.currentQuestion!.correctIndex {
                                                CustomButton(
                                                    buttonText: model.currentQuestion!.answers[index],
                                                    buttonColor: .green,
                                                    buttonTextColor: .black
                                                )
                                            }
                                            // Wrong answer submitted
                                            else if index == selectedAnswer &&
                                                        index != model.currentQuestion!.correctIndex {
                                                CustomButton(
                                                    buttonText: model.currentQuestion!.answers[index],
                                                    buttonColor: .red,
                                                    buttonTextColor: .black
                                                )
                                            }
                                            // Show correct answer
                                            else if index == model.currentQuestion!.correctIndex {
                                                CustomButton(
                                                    buttonText: model.currentQuestion!.answers[index],
                                                    buttonColor: .green,
                                                    buttonTextColor: .black
                                                )
                                            }
                                            // All other answers
                                            else {
                                                CustomButton(
                                                    buttonText: model.currentQuestion!.answers[index],
                                                    buttonColor: .white,
                                                    buttonTextColor: .gray
                                                )
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                }
                                .disabled(answerSubmitted)
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                // Submit button
                Button {
                    // Move to next question
                    if answerSubmitted {
                        model.nextTestQuestion()
                        
                        answerSubmitted = false
                        selectedAnswer = nil
                    } else {
                        // Show answer
                        answerSubmitted = true
                        if selectedAnswer == model.currentQuestion!.correctIndex {
                            correctAnswerCount += 1
                        }
                        
                    }
                } label: {
                    CustomButton(
                        buttonText: submitButtonText,
                        buttonColor: .green,
                        buttonTextColor: (selectedAnswer == nil ? .gray : .white)
                    )
                }
                .disabled(selectedAnswer == nil)
                
                
            }
            .navigationTitle("\(model.currentModule?.category ?? "") Test")
            .padding()
            
        } else {
            ProgressView()
        }
    }
}

extension TestView {
    
    var submitButtonText: String {
        
        if answerSubmitted {
            // Last question
            if model.currentTestIndex + 1 == model.currentModule!.test.questions.count {
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
