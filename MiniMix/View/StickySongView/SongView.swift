//
//  SongView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/5/23.
//  Inspiration and Tutorials: https://www.youtube.com/@Kavsoft
//

import SwiftUI
import ShazamKit
import MusicKit

// TODO: Header ViewBuilder could be seperated for code conciseness and legibility.

struct SongView: View {
    // Data Variables
    @Binding var song: BinarySong?
    @Binding var shazamHelper: ShazamKitHelper?
    var safeArea: EdgeInsets
    var size: CGSize
    
    // UI State Variables
    @State var addedSongToLibrary: Bool = false
    @Binding var isShowingSong: Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                // MARK: SONG COVER ART
                coverArt(size: size, safeArea: safeArea, song: song)
                
                GeometryReader { proxy in
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    - safeArea.top
                    
                    // MARK: MUSIC AND SHAZAM LINK BUTTONS
                    appButtons(minY: minY, song: song)
                
                }
                .frame(height: 50)
                .padding(.top, -4)
                .zIndex(1)
                
                // MARK: TRACK DATA
                TrackDataView(song: $song)
                    .padding(.top, 10)
                    .zIndex(0)
            }
            .overlay(alignment: .top) {
                // MARK: STICKY HEADER
                HeaderView()
            }
        }
        .background(Color.black)
        .coordinateSpace(name: "SCROLL")
    }
    
    // MARK: REUSABLE STICKY HEADER BUILDER
    @ViewBuilder
    func HeaderView() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let height = size.height * 0.7
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            let titleProgress = minY / height
            
            
            HStack(spacing: 15) {
                //MARK: RETURN ARROW
                Button(action: {
                    isShowingSong = false
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                })
                
                Spacer(minLength: 0)
                
                //MARK: ADD TO SHAZAM LIBRARY BUTTON
                Button(action: {
                    if let songToAdd = song {
                        shazamHelper?.addToShazamLibrary(songs: [songToAdd.shazamKitData])
                        addedSongToLibrary = true
                    } else {
                        print("DEBUG: Error adding song to Shazam Library, song was nil")
                    }
                }, label: {
                    if addedSongToLibrary {
                        Label("ADDED", systemImage: "checkmark.circle")
                            .font(.poppins(.semibold, size: 13))
                            .labelStyle(.trailingIcon)
                    } else {
                        Label("ADD", systemImage: "shazam.logo")
                            .font(.poppins(.semibold, size: 13))
                            .labelStyle(.trailingIcon)
                    }
                    
                })
                .buttonStyle(NeoBrutalismRectButtonStyle(color: .green))
                .opacity(1 + progress)
                .disabled(addedSongToLibrary)
            }
            //MARK: HEADER SONG TITLE
            .overlay(content: {
                Text(song?.shazamKitData.title ?? "Song Title")
                    .font(.poppins(.semibold, size: 15))
                    .offset(y: -titleProgress > 0.75 ? 0 : 45)
                    .clipped()
                    .animation(.easeInOut(duration: 0.25), value: -titleProgress > 0.75)
            })
            .padding(.top, safeArea.top + 10)
            .padding([.horizontal, .bottom], 15)
            .background(content: {
                Color.miniBlue
                    .opacity(-progress > 1 ? 1 : 0)
            })
            .offset(y: -minY)
        }
        .frame(height: 55)
    }
}
