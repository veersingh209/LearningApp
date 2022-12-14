//
//  ContentView-Details.swift
//  LearningApp
//
//  Created by Veer Singh on 8/31/22.
//

import SwiftUI
import AVKit

struct ContentView_Details: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.hostedVideoUrl + (lesson?.video ?? ""))
        
        VStack {
            
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))
            }
            
            UITextViews()
            
            if model.hasNextLesson() {
                Button {
                    model.nextLesson()
                } label: {
                    ZStack {
                        
                        CustomButton(
                            buttonText: ("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)"),
                            buttonColor: Color.green,
                            buttonTextColor: Color.white
                        )

                    }
                }

            } else {
                Button {
                    model.selectedContent = nil
                } label: {
                    ZStack {
                        
                        CustomButton(
                            buttonText: ("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)"),
                            buttonColor: Color.green,
                            buttonTextColor: Color.white
                        )

                    }
                }

            }
            
            
            
        }
        .navigationTitle(model.currentLesson?.title ?? " ")
        .padding()
        
    }
}
//
//struct ContentView_Details_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView_Details()
//    }
//}
