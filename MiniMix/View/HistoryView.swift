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
                
                ForEach(User.globalUser.shazamRequestHistory, id: \.id) { song in
                    Text(song.shazamKitData.title ?? "Unknown")
                        .onTapGesture {
                            songDetailsPresented = true
                            selectedSong = song
                        }
                }
            }
            .sheet(isPresented: $songDetailsPresented) {
                SongSizingView(song: $selectedSong, isShowingSong: $songDetailsPresented, shazamHelper: $shazamHelper)
            }
        }
    }
}
