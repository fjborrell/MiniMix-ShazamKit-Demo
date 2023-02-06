//
//  SongTileView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/6/23.
//

import SwiftUI
import MusicKit
import ShazamKit

struct SongTileView: View {
    var song: BinarySong?
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                AsyncImage(url: song?.shazamKitData.artworkURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .colorInvert()
                }
                .frame(width: 200, height: 200)
            }
            .background(Color.miniBlue)
            .cornerRadius(3)
            .shadow(color: .black, radius: 0, x: 6, y: 6)
            
            HStack {
                Text(song?.shazamKitData.title ?? "Song Title")
                    .font(.poppins(.medium, size: 12))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 5)
                    .frame(maxWidth: 200, maxHeight: 50)
            }
            .background(Color.miniGrey)
            .padding(.top, 150)
        }
    }
}

struct SongTileView_Previews: PreviewProvider {
    static var previews: some View {
        SongTileView(song: nil)
    }
}
