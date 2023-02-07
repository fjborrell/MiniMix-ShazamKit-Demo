//
//  MiscDataView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/7/23.
//

import SwiftUI

struct MiscDataView: View {
    @Binding var song: BinarySong?
    
    var body: some View {
        Text("Extra Track Info.")
            .font(.poppins(.medium, size: 18))
            .foregroundColor(.miniIce)
        
        
        VStack (alignment: .center, spacing: 15) {
            
            // MARK: MUSIC VIDEO (via Apple Music)
            Link("Music Video", destination: (song?.shazamKitData.videoURL ?? URL(string: "https://music.apple.com/us/browse"))!)
                .font(.poppins(.bold, size: 15))
                .foregroundColor(.blue)
            
            // MARK: INTERNATIONAL STANDARD RECORDING CODE
            HStack {
                Text("ISRC: ")
                    .bold()
                    .foregroundColor(.white)
                Text(song?.shazamKitData.isrc ?? "N/A")
                    .foregroundColor(.pink)
            }
            .font(.poppins(.regular, size: 15))
            
            // MARK: CONTENT RATING
            HStack {
                Text("Content Rating: ")
                    .bold()
                    .foregroundColor(.white)
                switch (song?.shazamKitData.explicitContent) {
                case true:
                    Text("Explicit")
                        .foregroundColor(.pink)
                case false:
                    Text("Clean")
                        .foregroundColor(.pink)
                case .none, .some(_):
                    Text("N/A")
                        .foregroundColor(.pink)
                }
            }
            .font(.poppins(.regular, size: 15))
            
            
            // MARK: EXTRA TRACK INFORMATION
            if song?.musicKitData != nil {
                // Track Duration
                HStack {
                    Text("Duration: ")
                        .bold()
                        .foregroundColor(.white)
                    Text(song?.musicKitData?.duration?.stringFormatted() ?? "N/A")
                        .foregroundColor(.pink)
                }
                .font(.poppins(.regular, size: 15))
                
                // Track Release Date
                HStack {
                    Text("Release Date: ")
                        .bold()
                        .foregroundColor(.white)
                    Text(song?.musicKitData?.releaseDate?.stringFormatted() ?? "N/A")
                        .foregroundColor(.pink)
                }
                .font(.poppins(.regular, size: 15))
                
                // Track Editorial Notes
                HStack {
                    Text("Editorial Notes: ")
                        .bold()
                        .foregroundColor(.white)
                    Text(song?.musicKitData?.editorialNotes?.short ?? "N/A")
                        .foregroundColor(.pink)
                }
                .font(.poppins(.regular, size: 15))
            }
        }
    }
}

//struct MiscDataView_Previews: PreviewProvider {
//    static var previews: some View {
//        MiscDataView()
//    }
//}
