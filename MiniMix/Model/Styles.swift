//
//  Styles.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/3/23.
//

import Foundation
import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

// Allows the label style to be called with dot notation
extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: Self { Self() }
}

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

//Default grey color
extension ButtonStyle where Self == NeoBrutalismRectButtonStyle {
    static var neobrutalismRect: Self { Self(color: .miniGrey) }
}

extension ButtonStyle where Self == NeoBrutalismCircleButtonStyle {
    static var neobrutalismCircle: Self { Self(color: .miniGrey) }
}
