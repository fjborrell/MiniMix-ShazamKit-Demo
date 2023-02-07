//
//  RootView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/4/23.
//

import SwiftUI

struct RootView: View {
    @State var isShowingSong: Bool = false
    @State var shazamHelper: ShazamKitHelper? = nil
    
    var body: some View {
        TabView() {
            ListenView(shazamHelper: $shazamHelper, isShowingSong: $isShowingSong)
                .tabItem {
                    Text("Listen")
                    Image(systemName: "waveform.and.mic")
                }
                .tag(0)
            HistoryView(shazamHelper: $shazamHelper, songDetailsPresented: $isShowingSong)
                .tabItem {
                    Text("History")
                    Image(systemName: "clock.fill")
                }
                .tag(1)
        }
        .tint(.pink)
        .navigationBarBackButtonHidden(true)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
