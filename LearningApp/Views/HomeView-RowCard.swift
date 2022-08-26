//
//  HomeView-RowCard.swift
//  LearningApp
//
//  Created by Veer Singh on 8/25/22.
//

import SwiftUI

struct HomeView_RowCard: View {
    
    var image: String
    var category: String
    var description: String
    var lessonsCount: Int
    var time: String
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
            
            
            
            HStack {
                
                Image(image)
                    .resizable()
                    .frame(width: 116, height: 116)
                    .clipShape(Circle())
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(category)
                        .bold()
                    
                    Text(description)
                        .font(.caption)
                        .padding(.bottom, 20)
                    
                    HStack {
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text("\(lessonsCount) Lessons")
                            .font(Font.system(size: 10))
                        
                        
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text("\(time) Hours")
                            .font(Font.system(size: 10))
                    }
                    
                }
                .padding(.leading, 5)
            }
            .padding(.horizontal, 20)
            
        }
        .padding([.leading, .bottom, .trailing], 20)
    }
}

struct HomeView_RowCard_Previews: PreviewProvider {
    static var previews: some View {
        HomeView_RowCard(image: "testSwift", category: "Swift", description: "Understand the fundamentals of the Swift programming language.", lessonsCount: 10, time: "3")
    }
}
