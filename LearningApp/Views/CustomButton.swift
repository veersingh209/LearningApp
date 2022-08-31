//
//  CustomButton.swift
//  LearningApp
//
//  Created by Veer Singh on 8/31/22.
//

import SwiftUI

struct CustomButton: View {
    var buttonText: String
    var buttonColor: Color
    var buttonTextColor: Color
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .frame(height: 48)
                .foregroundColor(buttonColor)
                .cornerRadius(10)
                .shadow(radius: 5)
            
            
            Text(buttonText)
                .foregroundColor(buttonTextColor)
                .bold()
        }
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(
            buttonText: "Test Button",
            buttonColor: Color.green,
            buttonTextColor: Color.white
        )
    }
}
