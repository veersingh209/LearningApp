//
//  LearningApp.swift
//  LearningApp
//
//  Created by Veer Singh on 8/25/22.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
