//
//  Fonts.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/3/23.
//

import Foundation
import SwiftUI

// Defines a custom enumeration for the "Poppins-Font" within Font().
extension Font {
    enum PoppinsFont {
        case black
        case extrabold
        case bold
        case semibold
        case medium
        case regular
        case light
        case extralight
        case thin
        case italic
            
        // Converts the font value from enum to String for usage within Font()
        var value: String {
            switch self {
            case .black:
                return "Poppins-Black"
            case .extrabold:
                return "Poppins-ExtraBold"
            case .bold:
                return "Poppins-Bold"
            case .semibold:
                return "Poppins-SemiBold"
            case .medium:
                return "Poppins-Medium"
            case .regular:
                return "Poppins-Regular"
            case .light:
                return "Poppins-Light"
            case .extralight:
                return "Poppins-ExtraLight"
            case .thin:
                return "Poppins-Thin"
            case .italic:
                return "Poppins-Italic"
            }
        }
    }
    
    // Enables the Poppins-Font to be called accessed with dot notation (e.g. .font(.poppins(.bold, 12)))
    static func poppins(_ type: PoppinsFont, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
}
