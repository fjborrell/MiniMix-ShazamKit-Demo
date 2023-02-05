//
//  StickySongView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/5/23.
//

import SwiftUI
import ShazamKit

struct SongView: View {
    @Binding var song: SHMediaItem?
    
    
    var safeArea: EdgeInsets
    var size: CGSize
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                // MARK: Artwork
                Artwork()
                
                GeometryReader { proxy in
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    - safeArea.top
                    
                    HStack(spacing: 20) {
                        //Apple Music Button
                        Link(destination: (song?.appleMusicURL ?? URL(string: "https://music.apple.com/us/browse"))!, label: {
                            Label("APPLE MUSIC", systemImage: "apple.logo")
                        })
                        .buttonStyle(NeoBrutalismRectButtonStyle(color: .pink))
                        .font(.poppins(.semibold, size: 14))
                        
                        //Shazam Button
                        Link(destination: (song?.webURL ?? URL(string: "https://www.shazam.com"))!, label: {
                            Label("SHAZAM", systemImage: "shazam.logo.fill")
                        })
                        .buttonStyle(NeoBrutalismRectButtonStyle(color: .blue))
                        .font(.poppins(.semibold, size: 14))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .offset(y: minY < 50 ? -(minY - 60) : 0)
                }
                .frame(height: 50)
                .padding(.top, -34)
                .zIndex(1)
                
                VStack {
                    Text("Track Data")
                        .fontWeight(.heavy)
                    
                    // MARK: Album View
                    AlbumView()
                }
                .padding(.top, 10)
                .zIndex(0)
            }
            .overlay(alignment: .top) {
                HeaderView()
            }
        }
        .background(.black)
        .coordinateSpace(name: "SCROLL")
    }
    
    @ViewBuilder
    func Artwork() -> some View {
        let height = size.height * 0.45
        GeometryReader { proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            
            //Cover Art
            AsyncImage(
                url: song?.artworkURL
            ) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0))
                    .clipped()
                    .overlay(content: {
                        ZStack(alignment: .bottom) {
                            // MARK: Gradient Overlay
                            Rectangle()
                                .fill(
                                    .linearGradient(colors: [.black.opacity(0 - progress), .black.opacity(0.1 - progress), .black.opacity(0.4 - progress), .black.opacity(0.6 - progress), .black], startPoint: .top, endPoint: .bottom)
                                )
                            
                            VStack(spacing: 0) {
                                Text(song?.title ?? "Song Title")
                                    .font(.poppins(.bold, size: 35))
                                    .multilineTextAlignment(.center)
                                
                                Text(song?.artist ?? "Artist")
                                    .font(.poppins(.bold, size: 20))
                                    .foregroundColor(.gray)
                                    .padding(.top, 8)
                            }
                            .opacity(1 + (progress > 0 ? -progress : progress))
                            .padding(.bottom, 55)
                            //Moving with ScrollView
                            .offset(y: minY < 0 ? minY : 0)
                        }
                    })
                    .offset(y: -minY)
            } placeholder: {
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0))
                    .overlay(content: {
                        ZStack(alignment: .bottom) {
                            // MARK: Gradient Overlay
                            Rectangle()
                                .fill(
                                    .linearGradient(colors: [.black.opacity(0 - progress), .black.opacity(0.1 - progress), .black.opacity(0.4 - progress), .black.opacity(0.6 - progress), .black], startPoint: .top, endPoint: .bottom)
                                )
                            
                            VStack(spacing: 0) {
                                Text(song?.title ?? "Song Title")
                                    .font(.poppins(.bold, size: 35))
                                    .multilineTextAlignment(.center)
                                
                                Text(song?.artist ?? "Artist")
                                    .font(.poppins(.bold, size: 20))
                                    .foregroundColor(.gray)
                                    .padding(.top, 8)
                            }
                            .opacity(1 + (progress > 0 ? -progress : progress))
                            .padding(.bottom, 55)
                            //Moving with ScrollView
                            .offset(y: minY < 0 ? minY : 0)
                        }
                    })
                
            }
        }
        .frame(height: height + safeArea.top)
    }
    
    @ViewBuilder
    func AlbumView() -> some View {
        VStack(spacing: 25) {
            ForEach(song?.genres.indices ?? ["Unknown"].indices, id: \.self) { index in
                HStack(spacing: 25) {
                    Label(song?.genres[index] ?? "Unknown", systemImage: "music.note")
                        .font(.poppins(.semibold, size: 12))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(15)
    }
    
    // MARK: HeaderView
    @ViewBuilder
    func HeaderView() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let height = size.height * 0.45
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            let titleProgress = minY / height
            
            HStack(spacing: 15) {
                Button(action: {
                    
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                })
                
                Spacer(minLength: 0)
                
                Button(action: {
                    
                }, label: {
                    Text("FOLLOWING")
                        .font(.poppins(.semibold, size: 13))
                })
                .buttonStyle(NeoBrutalismRectButtonStyle(color: .green))
                .opacity(1 + progress)
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.white)
                })
            }
            .overlay(content: {
                Text(song?.title ?? "Song Title")
                    .font(.poppins(.semibold, size: 15))
                    .offset(y: -titleProgress > 0.75 ? 0 : 45)
                    .clipped()
                    .animation(.easeInOut(duration: 0.25), value: -titleProgress > 0.75)
            })
            .padding(.top, safeArea.top + 10)
            .padding([.horizontal, .bottom], 15)
            .background(content: {
                Color.black
                    .opacity(-progress > 1 ? 1 : 0)
            })
            .offset(y: -minY)
        }
        .frame(height: 35)
    }
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
        SongSizingView(song: .constant(SHMediaItem(properties: [SHMediaItemProperty("Test Property"): "Test Value"])))
    }
}
