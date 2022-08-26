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
        
        let lesson = model.currentModule!.content.lessons[index]
        
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


//struct ContentView_RowCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView_RowCard()
//    }
//}
