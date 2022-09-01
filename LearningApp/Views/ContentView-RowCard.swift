//
//  ContentView-RowCard.swift
//  LearningApp
//
//  Created by Veer Singh on 8/25/22.
//

import SwiftUI

struct ContentView_RowCard: View {
    
    @EnvironmentObject var model: ContentModel
    var index: Int
    
    var body: some View {
                
        ZStack (alignment: .leading) {
            
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .frame(height: 66)
            
            HStack(spacing: 30.0) {
                
                Text(String(index + 1))
                
                VStack(alignment: .leading) {
                    
                    Text(lesson.title)
                        .fontWeight(.bold)
                    
                    Text(lesson.duration)
                }
                
            }
            .padding()
        }
        
    }
}

extension ContentView_RowCard {
    var lesson: Lessons {
        if model.currentModule != nil && index < model.currentModule!.content.lessons.count {
            return model.currentModule!.content.lessons[index]
        } else {
            return Lessons(id: 0, title: " ", video: " ", duration: " ", explanation: " ")
        }
    }
}


//struct ContentView_RowCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView_RowCard()
//    }
//}
