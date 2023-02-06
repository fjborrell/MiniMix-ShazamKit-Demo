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
            
            Text("Genres")
                .font(.poppins(.semibold, size: 14))
            ForEach(song?.shazamKitData.genres ?? ["Music"], id: \.self) { genre in
                HStack(spacing: 25) {
                    Label(genre.description, systemImage: "music.note")
                        .font(.poppins(.semibold, size: 12))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Text("Genres")
                .font(.poppins(.semibold, size: 14))
            
            Text(song?.musicKitData?.albumTitle ?? "Album Title")
            Text(song?.musicKitData?.albums?.description ?? "Associated Albums")
            Text(song?.musicKitData?.isrc ?? "ISRC")
            Text(song?.musicKitData?.duration?.description ?? "Duration")
            Text(song?.musicKitData?.releaseDate?.description ?? "Release Date")
        }
        .padding(15)
        .onAppear {
            
        }
    }
}
