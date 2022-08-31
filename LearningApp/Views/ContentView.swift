//
//  ContentView.swift
//  LearningApp
//
//  Created by Veer Singh on 8/25/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        ScrollView {
            
            LazyVStack {
                
                if model.currentModule != nil {
                
                    ForEach(0..<model.currentModule!.content.lessons.count) { index in
                        NavigationLink {
                            ContentView_Details()
                                .onAppear {
                                    model.startLesson(index)
                                }
                        } label: {
                            ContentView_RowCard(index: index)
                        }
                        .buttonStyle(.plain)

                    }
                }
            }
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
            
        }
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
