//
//  ArtistDataView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/7/23.
//

import SwiftUI

struct ArtistDataView: View {
    @Binding var song: BinarySong?
    
    var body: some View {
        // MARK: SECTION TITLE
        Text("Artist Data")
            .font(.poppins(.medium, size: 18))
            .foregroundColor(.miniIce)
        
        VStack(alignment: .center, spacing: 10) {
            // MARK: ARTIST(S) NAME(S)
            Text(song?.shazamKitData.artist ?? "N/A")
                .font(.poppins(.medium, size: 15))
                .foregroundColor(.pink)
                .multilineTextAlignment(.center)
            
            // MARK: ARTIST'S PROFILE LINK
            // Only present if the track has available MusicKit data
            if song?.musicKitData != nil {
                Link("Apple Music Profile", destination: ((song?.musicKitData?.artistURL) ?? URL(string: "https://music.apple.com/us/browse"))!)
                    .font(.poppins(.bold, size: 15))
                    .foregroundColor(.blue)
            }
        }
    }
}

//struct ArtistDataView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArtistDataView()
//    }
//}
