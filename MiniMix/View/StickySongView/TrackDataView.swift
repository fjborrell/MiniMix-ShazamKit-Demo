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
    @Binding var shazamKitSong: SHMediaItem?
    @State private var musicKitSongResponse: MySongResponse?
    @State private var musicKitSong: Song?
    @Binding var isAuthorizedForMusicKit: Bool
    
    var body: some View {
        VStack(spacing: 25) {
            
            Text("Genres")
                .font(.poppins(.semibold, size: 14))
            ForEach(shazamKitSong?.genres ?? ["Music"], id: \.self) { genre in
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
            
            Text(musicKitSong?.albumTitle ?? "Album Title")
            Text(musicKitSong?.albums?.description ?? "Associated Albums")
            Text(musicKitSong?.isrc ?? "ISRC")
            Text(musicKitSong?.duration?.description ?? "Duration")
            Text(musicKitSong?.releaseDate?.description ?? "Release Date")
        }
        .padding(15)
        .onAppear {
            if isAuthorizedForMusicKit {
                Task {
                    musicKitSongResponse = await shazamKitSong?.getMusicKitSong() ?? nil
                    musicKitSong = (musicKitSongResponse?.data.first)!
                }
            }
        }
    }
}

struct TrackDataView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            TrackDataView(shazamKitSong: .constant(SHMediaItem(properties: [SHMediaItemProperty("genres"): ["Test Value"]])), isAuthorizedForMusicKit: .constant(true))
        }
        
    }
}
