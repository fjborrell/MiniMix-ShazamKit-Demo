//
//  MiniMixApp.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/2/23.
//

import SwiftUI

@main
struct MiniMixApp: App {
    // Watches a key in UserDefaults: Has user already launched the app before
    @AppStorage("hasSeenWelcomeScreen")
    private var hasSeenWelcomeScreen: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if hasSeenWelcomeScreen {
                RootView()
            } else {
                WelcomeView()
            }
            
        }
    }
}
