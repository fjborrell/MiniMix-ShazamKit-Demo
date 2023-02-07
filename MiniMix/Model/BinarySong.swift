//
//  BinarySong.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/6/23.
//

import Foundation
import MusicKit
import ShazamKit


// Custom data type that consolidates a ShazamKit SHMediaItem and a MusicKit Song into a single identifiable type
struct BinarySong: Identifiable {
    let id = UUID()
    var shazamKitData: SHMediaItem
    var musicKitData: Song?
}
