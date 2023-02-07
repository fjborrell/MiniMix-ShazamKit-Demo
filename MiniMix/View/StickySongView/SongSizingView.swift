//
//  SongSizingView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/5/23.
//

import SwiftUI
import ShazamKit
import MusicKit

struct SongSizingView: View {
    // Data Variables
    @Binding var song: BinarySong?
    @Binding var shazamHelper: ShazamKitHelper?
    
    // UI State Variables
    @Binding var isShowingSong: Bool
    
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            SongView(song: $song, shazamHelper: $shazamHelper, safeArea: safeArea, size: size, isShowingSong: $isShowingSong)
                .ignoresSafeArea(.container, edges: .top)
        }
        .preferredColorScheme(.dark)
    }
}
