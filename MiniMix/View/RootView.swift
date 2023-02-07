//
//  RootView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/4/23.
//

import SwiftUI

struct RootView: View {
    // Watches a key in UserDefaults: Has user already launched the app before
    @AppStorage("hasSeenWelcomeScreen")
    private var hasSeenWelcomeScreen: Bool = false
    
    @State var isShowingSong: Bool = false
    @State var shazamHelper: ShazamKitHelper? = nil
    
    var body: some View {
        TabView() {
            
            // MARK: "HOME PAGE" -> LISTEN BUTTON
            ListenView(shazamHelper: $shazamHelper, isShowingSong: $isShowingSong)
                .tabItem {
                    Text("Listen")
                    Image(systemName: "waveform.and.mic")
                }
                .tag(0)
            
            // MARK: USER SHAZAM REQUEST HISTORY
            HistoryView(shazamHelper: $shazamHelper)
                .tabItem {
                    Text("History")
                    Image(systemName: "clock.fill")
                }
                .tag(1)
        }
        .tint(.miniBlue)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            // Store in user defaults, WelcomeView will not be shown again
            hasSeenWelcomeScreen = true
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
