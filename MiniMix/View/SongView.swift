//
//  SongView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/4/23.
//

import SwiftUI
import ShazamKit

struct SongView: View {
    @Binding var song: SHMediaItem?
    @Binding var isShowingSong: Bool
    
    var body: some View {
        ZStack {
            Color.pastelBackground
                .ignoresSafeArea()
            
            VStack {
                
                //Cover Art
                AsyncImage(
                    url: song?.artworkURL
                ) { image in
                    image.resizable()
                } placeholder: {
                    VStack {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.miniBlue)
                                .frame(width: .infinity , height: 400)
                                .opacity(0.8)
                            
                            HStack {
                                Button(action: {
                                    isShowingSong = false
                                    
                                }, label: {
                                    Label("Back", systemImage: "arrow.left.circle")
                                })
                                .buttonStyle(.neobrutalismRect)
                                .font(.poppins(.regular, size: 14))
                                Spacer()
                            }
                            .padding()
                            
                            ProgressView()
                                .progressViewStyle(.circular)
                                .colorInvert()
                        }
                    }
                    .ignoresSafeArea()
                }
                
                //Metadeta
                Text(song?.title ?? "Song Title")
                    .font(.poppins(.bold, size: 30))
                Text(song?.artist ?? "Artist")
                    .font(.poppins(.medium, size: 20))
                Text(song?.subtitle ?? "Subtitle")
                
                //Apple Music Button
                Link(destination: (song?.appleMusicURL ?? URL(string: "https://music.apple.com/us/browse"))!, label: {
                    Label("Apple Music", systemImage: "apple.logo")
                })
                .buttonStyle(NeoBrutalismRectButtonStyle(color: .pink))
                .font(.poppins(.semibold, size: 14))
                
                //Shazam Button
                Link(destination: (song?.webURL ?? URL(string: "https://www.shazam.com"))!, label: {
                    Label("Shazam", systemImage: "shazam.logo.fill")
                })
                .buttonStyle(NeoBrutalismRectButtonStyle(color: .blue))
                .font(.poppins(.semibold, size: 14))
                
                Spacer()
                
                
            }
        }
        
    }
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
        SongView(song: .constant(SHMediaItem(properties: [SHMediaItemProperty("Test Property"): "Test Value"])), isShowingSong: .constant(false))
    }
}
