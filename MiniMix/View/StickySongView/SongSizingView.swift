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
    @Binding var isShowingSong: Bool
    @Binding var shazamHelper: ShazamKitHelper?
    @Binding var isAuthorizedForMusicKit: Bool
    
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            SongView(song: $song, isShowingSong: $isShowingSong, shazamHelper: $shazamHelper, isAuthorizedForMusicKit: $isAuthorizedForMusicKit, safeArea: safeArea, size: size)
                .ignoresSafeArea(.container, edges: .top)
        }
        .preferredColorScheme(.dark)
    }
}
