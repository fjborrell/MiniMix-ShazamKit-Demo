//
//  BinarySong.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/6/23.
//

import Foundation
import MusicKit
import ShazamKit

struct BinarySong: Identifiable {
    let id = UUID()
    var shazamKitData: SHMediaItem
    var musicKitData: Song?
}
