//
//  HistoryView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/4/23.
//

import SwiftUI
import ShazamKit

struct HistoryView: View {
    @Binding var shazamHelper: ShazamKitHelper?
    @Binding var songDetailsPresented: Bool
    @State var selectedSong: BinarySong? = nil
    @State var songHistory = User.globalUser.getShazamRequestHistory()
    
    var items: [GridItem] {
      Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
    }
    
    var body: some View {
        ZStack {
            Color.pastelBackground
                .ignoresSafeArea()
            
            VStack {
                Text("Shazam Request History")
                    .font(.poppins(.semibold, size: 25))
                    .padding([.vertical], 30)
                    .padding([.horizontal], 50)
                    .multilineTextAlignment(.center)
                
                Spacer()
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(songHistory, id: \.id) { song in
                        LazyVGrid(columns: items, spacing: 10) {
                            SongTileView(song: song)
                                .onTapGesture {
                                    selectedSong = song
                                    songDetailsPresented = true
                                }
                        }
                        .padding(.horizontal)                            
                    }
                }
            }
            .sheet(isPresented: $songDetailsPresented) {
                SongSizingView(song: $selectedSong, isShowingSong: $songDetailsPresented, shazamHelper: $shazamHelper)
            }
        }
    }
}
