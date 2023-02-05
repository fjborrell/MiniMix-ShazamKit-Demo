//
//  SongView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/4/23.
//

import SwiftUI
import ShazamKit

struct SongView: View {
    @Binding var song: SHMediaItem?
    @Binding var isShowingSong: Bool
    
    var body: some View {
        VStack {
            Button("Back", action: {
                isShowingSong = false
            })
            
            //Cover Art
            AsyncImage(
                url: song?.artworkURL
            ) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            
            //Metadeta
            Text(song?.title ?? "Song Title")
            Text(song?.artist ?? "Artist")
            Text(song?.subtitle ?? "Subtitle")
        }
        
    }
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
        SongView(song: .constant(SHMediaItem(properties: [SHMediaItemProperty("Test Property"): "Test Value"])), isShowingSong: .constant(false))
    }
}
