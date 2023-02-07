//
//  HistoryView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/4/23.
//

import SwiftUI
import ShazamKit

struct HistoryView: View {
    // Data Variables
    @State var selectedSong: BinarySong? = nil
    @Binding var shazamHelper: ShazamKitHelper?
    @ObservedObject var userData = User.globalUser
    
    // UI State Variables
    @State var songDetailsPresented: Bool = false
    var tiles: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            // MARK: SCREEN BACKGROUND
            Color.pastelBackground
                .ignoresSafeArea()
            
            VStack {
                // MARK: VIEW TITLE
                Text("Shazam Request History")
                    .font(.poppins(.semibold, size: 25))
                    .foregroundColor(.white)
                    .padding([.vertical], 30)
                    .padding([.horizontal], 50)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                // MARK: SCROLLABLE SONG HISTORY GRID
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: tiles, spacing: 20) {
                        ForEach(userData.getShazamRequestHistory().reversed(), id: \.id) { song in
                            SongTileView(song: song)
                                .onTapGesture {
                                    selectedSong = song
                                    songDetailsPresented = true
                                }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            // When a song in history is tapped, present a song data sheet with that specific track's data.
            .sheet(isPresented: $songDetailsPresented) {
                SongSizingView(song: $selectedSong, shazamHelper: $shazamHelper, isShowingSong: $songDetailsPresented)
            }
        }
    }
}
