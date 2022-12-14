//
//  HomeView.swift.swift
//  LearningApp
//
//  Created by Veer Singh on 8/25/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading, spacing: 0.0) {
                Text("What do you want to do today?")
                    .font(.title3)
                    .padding([.leading, .bottom])
                
                ScrollView {
                    
                    LazyVStack {
                        
                        ForEach(model.modules) { module in
                            
                            NavigationLink(
                                destination:
                                    ContentView()
                                    .onAppear (perform: {
                                        model.startingModule(module.id)
                                    }),
                                tag: module.id,
                                selection: $model.selectedContent,
                                label: {
                                    HomeView_RowCard(image: module.content.image, category: "Learn \(module.category)", description: module.content.description, lessonsCount: module.content.lessons.count, time: module.content.time)
                                })
                            .buttonStyle(PlainButtonStyle())
                            
                            NavigationLink(
                                destination:
                                    TestView()
                                    .onAppear (perform: {
                                        model.startTest(module.id)
                                    }),
                                tag: module.id,
                                selection: $model.selectedTest,
                                label: {
                                    HomeView_RowCard(image: module.test.image, category: "\(module.category) Test", description: module.test.description, lessonsCount: module.test.questions.count, time: module.test.time)
                                })
                            .buttonStyle(PlainButtonStyle())

                        }
                    }
                    .padding(.top)
                    
                }
            }
            .navigationTitle("Get Started")
            .onChange(of: model.selectedContent) { newValue in
                if newValue == nil {
                    model.currentModule = nil
                }
            }
            .onChange(of: model.selectedTest) { newValue in
                if newValue == nil {
                    model.currentModule = nil
                }
            }
        }
        .navigationViewStyle(.stack)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
