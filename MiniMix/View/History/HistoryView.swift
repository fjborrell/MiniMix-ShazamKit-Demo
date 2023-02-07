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
    @ObservedObject var user = User.globalUser
    
    var tiles: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
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
                    LazyVGrid(columns: tiles, spacing: 20) {
                        ForEach(user.getShazamRequestHistory().reversed(), id: \.id) { song in
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
            .sheet(isPresented: $songDetailsPresented) {
                SongSizingView(song: $selectedSong, isShowingSong: $songDetailsPresented, shazamHelper: $shazamHelper)
            }
        }
    }
}
