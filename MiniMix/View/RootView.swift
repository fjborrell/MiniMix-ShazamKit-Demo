//
//  RootView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/4/23.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView() {
            ListenView()
                .tabItem {
                    Text("Listen")
                    Image(systemName: "waveform.and.mic")
                }
                .tag(0)
            HistoryView()
                .tabItem {
                    Text("History")
                    Image(systemName: "clock.fill")
                }
                .tag(1)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
