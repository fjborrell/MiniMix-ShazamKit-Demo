//
//  TrackDataView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/5/23.
//

import SwiftUI
import ShazamKit
import MusicKit

struct TrackDataView: View {
    @Binding var song: BinarySong?
    
    var body: some View {
        VStack(spacing: 25) {
            
            // MARK: INFO INDICATOR
            VStack {
                Text("Track Information")
                    .font(.poppins(.bold, size: 20))
                Image(systemName: "arrow.down.circle")
                    .imageScale(.large)
                    .bold()
            }
            .padding(.vertical, 40)
            .foregroundColor(.white)
            
            Divider()
            
            // MARK: ARTIST DATA
            ArtistDataView(song: $song)
            
            Divider()
            
            // MARK: GENRE DATA
            GenreDataView(song: $song)
            
            Divider()
            
            // MARK: ALBUM DATA
            AlbumDataView(song: $song)
            
            Divider()
            
            // MARK: EXTRA TRACK INFORMATION
            MiscDataView(song: $song)
        }
        .padding(15)
    }
}
