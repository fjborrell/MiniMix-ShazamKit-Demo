//
//  Styles.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/3/23.
//

import Foundation
import SwiftUI

// Defines a custom label style where the icon is to the right of the text
struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

// Allows the TrailingIconLabeltyle to be accessed with dot notation
extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: Self { Self() }
}


// TODO: Combine the custom NeoBrutalist button styles into one -> unnecessary code duplication, but need to figure out how to make the shape user-defined (e.g. Rectangle(), Circle(), RoundedRectagnle(), etc.)

// Defines a custom SQUARE button style with a harsh sharp shadow and a subtle scale effect
struct NeoBrutalismRectButtonStyle: ButtonStyle {
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(11)
            .background(
                Rectangle()
                    .foregroundColor(color)
                    .cornerRadius(3)
                    .shadow(color: .black, radius: 0, x: 6, y: 6)
            )
            .foregroundColor(.white)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

// Defines a custom CIRCULAR button style with a harsh sharp shadow and a subtle scale effect
struct NeoBrutalismCircleButtonStyle: ButtonStyle {
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(
                Circle()
                    .frame(width: 170, height: 170)
                    .foregroundColor(color)
                    .shadow(color: .black, radius: 0, x: 8, y: 8)
            )
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.05), value: configuration.isPressed)
    }
}

// Allows the NeoBrutalismRectButtonStyle to be accessed with dot notation
extension ButtonStyle where Self == NeoBrutalismRectButtonStyle {
    static var neobrutalismRect: Self { Self(color: .miniGrey) }
}

// Allows the NeoBrutalismCircleButtonStyle to be accessed with dot notation
extension ButtonStyle where Self == NeoBrutalismCircleButtonStyle {
    static var neobrutalismCircle: Self { Self(color: .miniGrey) }
}

// Generates a gradient that changes with a given scroll factor (Used in SongView)
@ViewBuilder
func scrollGradient(progressDelta: Double) -> some View {
    Rectangle()
        .fill(
            .linearGradient(colors: [
                .black.opacity(0 - progressDelta),
                .black.opacity(0.1 - progressDelta),
                .black.opacity(0.4 - progressDelta),
                .black.opacity(0.6 - progressDelta), .black
            ], startPoint: .top, endPoint: .bottom)
        )
}
