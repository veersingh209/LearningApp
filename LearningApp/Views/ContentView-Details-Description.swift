//
//  ContentView-Details-Description.swift
//  LearningApp
//
//  Created by Veer Singh on 8/31/22.
//

import SwiftUI

struct ContentView_Details_Description: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        
        return textView
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
        textView.attributedText = model.lessonTextDescription
        
        textView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
    }
    
}


struct ContentView_Details_Description_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_Details_Description()
    }
}
