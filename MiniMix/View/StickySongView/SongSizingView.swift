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
    @Binding var song: BinarySong?
    @Binding var isShowingSong: Bool
    @Binding var shazamHelper: ShazamKitHelper?
    
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            SongView(song: $song, isShowingSong: $isShowingSong, shazamHelper: $shazamHelper, safeArea: safeArea, size: size)
                .ignoresSafeArea(.container, edges: .top)
        }
        .preferredColorScheme(.dark)
    }
}
