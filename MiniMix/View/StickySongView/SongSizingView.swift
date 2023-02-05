//
//  SongSizingView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/5/23.
//

import SwiftUI
import ShazamKit

struct SongSizingView: View {
    @Binding var song: SHMediaItem?
    
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            SongView(song: $song, safeArea: safeArea, size: size)
                .ignoresSafeArea(.container, edges: .top)
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SongSizingView(song: .constant(SHMediaItem(properties: [SHMediaItemProperty("Test Property"): "Test Value"])))
    }
}
