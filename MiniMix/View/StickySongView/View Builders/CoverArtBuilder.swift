//
//  CoverArtBuilder.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/7/23.
//

import SwiftUI

// MARK: REUSABLE ARTWORK BUILDER
@ViewBuilder
func coverArt(size: CGSize, safeArea: EdgeInsets, song: BinarySong?) -> some View {
    let height = size.height * 0.7
    GeometryReader { proxy in
        let size = proxy.size
        let minY = proxy.frame(in: .named("SCROLL")).minY
        let scrollProgress = minY / (height * (minY > 0 ? 0.5 : 0.8))
        
        // MARK: ASYNC COVERT ART
        AsyncImage(
            url: song?.shazamKitData.artworkURL
        ) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0))
                .clipped()
                .overlay(content: {
                    ZStack(alignment: .bottom) {
                        // MARK: Gradient Overlay
                        scrollGradient(progressDelta: scrollProgress)
                        
                        VStack(spacing: 0) {
                            Text(song?.shazamKitData.title ?? "Song Title")
                                .font(.poppins(.bold, size: 35))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 10)
                            
                            Text(song?.shazamKitData.artist ?? "Artist")
                                .font(.poppins(.bold, size: 20))
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                                .padding(.horizontal, 10)
                                .multilineTextAlignment(.center)
                        }
                        .opacity(1 + (scrollProgress > 0 ? -scrollProgress : scrollProgress))
                        .padding(.bottom, 15)
                        //Moving with ScrollView
                        .offset(y: minY < 0 ? minY : 0)
                    }
                })
                .offset(y: -minY)
        } placeholder: {
            // While waiting for cover art to load
            ProgressView()
                .progressViewStyle(.circular)
                .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0))
                .overlay(content: {
                    ZStack(alignment: .bottom) {
                        // MARK: Gradient Overlay
                        scrollGradient(progressDelta: scrollProgress)
                    }
                })
        }
    }
    .frame(height: height + safeArea.top)
}
