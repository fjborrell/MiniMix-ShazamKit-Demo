//
//  AlbumDataView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/7/23.
//

import SwiftUI

struct AlbumDataView: View {
    @Binding var song: BinarySong?
    
    var body: some View {
        
        // MARK: SECTION TITLE
        Text("Album Data")
            .font(.poppins(.medium, size: 18))
            .foregroundColor(.miniIce)
        
        // Only present if the track has available MusicKit data
        if song?.musicKitData != nil {
            VStack (alignment: .center, spacing: 15) {
                
                // MARK: ALBUM TITLE
                HStack {
                    Text("Title: ")
                        .bold()
                        .foregroundColor(.white)
                    Text(song?.musicKitData?.albumTitle ?? "N/A")
                        .foregroundColor(.pink)
                }
                .font(.poppins(.regular, size: 15))
                .foregroundColor(.white)
                
                // MARK: TRACK NUMBER
                HStack {
                    Text("Track #: ")
                        .bold()
                        .foregroundColor(.white)
                    Text(song?.musicKitData?.trackNumber?.description ?? "N/A")
                        .foregroundColor(.pink)
                }
                .font(.poppins(.regular, size: 15))
                
                // MARK: DISC NUMBER
                HStack {
                    Text("Disc #: ")
                        .bold()
                        .foregroundColor(.white)
                    Text(song?.musicKitData?.discNumber?.description ?? "N/A")
                        .foregroundColor(.pink)
                }
                .font(.poppins(.regular, size: 15))
            }
        }
    }
}

//struct AlbumDataView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlbumDataView()
//    }
//}
