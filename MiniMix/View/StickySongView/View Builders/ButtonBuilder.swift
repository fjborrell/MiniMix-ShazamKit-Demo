//
//  ButtonBuilder.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/7/23.
//

import SwiftUI


// MARK: REUSABLE APP LINK BUTTONS
@ViewBuilder
func appButtons(minY: Double, song: BinarySong?) -> some View {
    
    HStack(spacing: 20) {
        
        // MARK: APPLE MUSIC BUTTON
        Link(destination: (song?.shazamKitData.appleMusicURL ?? URL(string: "https://music.apple.com/us/browse"))!, label: {
            Label("MUSIC", systemImage: "apple.logo")
        })
        .buttonStyle(NeoBrutalismRectButtonStyle(color: .pink))
        .font(.poppins(.semibold, size: 16))
        
        // MARK: SHAZAM BUTTON
        Link(destination: (song?.shazamKitData.webURL ?? URL(string: "https://www.shazam.com"))!, label: {
            Label("SHAZAM", systemImage: "shazam.logo.fill")
        })
        .buttonStyle(NeoBrutalismRectButtonStyle(color: .blue))
        .font(.poppins(.semibold, size: 16))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .offset(y: minY < 75 ? -(minY - 75) : 0)
}

