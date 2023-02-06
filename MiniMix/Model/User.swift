//
//  User.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/6/23.
//

import Foundation
import ShazamKit

class User {
    // Private reference to the singleton user
    static let globalUser: User = User()
    private var shazamRequestHistory: [BinarySong]
    
    // Private constructor to ensure client can't create new Users (singleton)
    private init(shazamRequestHistory: [BinarySong] = []) {
        self.shazamRequestHistory = shazamRequestHistory
    }
    
    func getShazamRequestHistory() -> [BinarySong] {
        return shazamRequestHistory
    }
    
    func addMediaToShazamHistory(item: BinarySong?) {
        guard let item = item else {
            return
        }
        shazamRequestHistory.append(item)
    }
}
