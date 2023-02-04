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

struct NeoBrutalismButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(11)
            .background(
                Rectangle()
                    .frame(minWidth: 300)
                    .foregroundColor(.miniGrey)
                    .cornerRadius(3)
                    .shadow(color: .black, radius: 0, x: 6, y: 6)

                    
            )
            .foregroundColor(.white)
            .font(.poppins(.semibold, size: 20))
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == NeoBrutalismButtonStyle {
    static var neobrutalism: Self { Self() }
}
