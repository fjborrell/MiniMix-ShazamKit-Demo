//
//  GenreDataView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/7/23.
//

import SwiftUI

struct GenreDataView: View {
    @Binding var song: BinarySong?
    
    var body: some View {
        
        // MARK: SECTION TITLE
        Text("Genres")
            .font(.poppins(.medium, size: 18))
            .foregroundColor(.miniIce)
        
        // MARK: GENRE LIST
        ForEach(song?.shazamKitData.genres ?? ["Music"], id: \.self) { genre in
            HStack(spacing: 40) {
                Label(genre.description, systemImage: "music.note")
                    .font(.poppins(.regular, size: 15))
                    .foregroundColor(.pink)
                    .cornerRadius(15)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

//struct GenreDataView_Previews: PreviewProvider {
//    static var previews: some View {
//        GenreDataView()
//    }
//}
