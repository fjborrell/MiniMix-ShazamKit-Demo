//
//  HistoryView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/4/23.
//

import SwiftUI
import ShazamKit

struct HistoryView: View {    
    @State var selectedSong: BinarySong? = nil
    @State var songDetailsPresented: Bool = false
    
    @Binding var shazamHelper: ShazamKitHelper?
    
    @ObservedObject var userData = User.globalUser
    
    var tiles: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            Color.pastelBackground
                .ignoresSafeArea()
            
            VStack {
                Text("Shazam Request History")
                    .font(.poppins(.semibold, size: 25))
                    .foregroundColor(.white)
                    .padding([.vertical], 30)
                    .padding([.horizontal], 50)
                    .multilineTextAlignment(.center)
                
                Spacer()
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
            .sheet(isPresented: $songDetailsPresented) {
                SongSizingView(song: $selectedSong, isShowingSong: $songDetailsPresented, shazamHelper: $shazamHelper)
            }
        }
    }
}
