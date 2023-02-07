//
//  Colors.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/3/23.
//

import Foundation
import SwiftUI

// Defines custom colors used within the app (enables access via dot notation)
extension Color {
    static let miniIce = Color("miniIce")
    static let miniSky = Color("miniSky")
    static let miniGrey = Color("miniGrey")
    static let miniBlue = Color("miniBlue")
    static let pastelBackground = LinearGradient(colors: [.miniIce, .miniSky], startPoint: .top, endPoint: .bottom)
}
