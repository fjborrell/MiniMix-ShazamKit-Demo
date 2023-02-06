//
//  User.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/6/23.
//

import Foundation
import ShazamKit

class User: ObservableObject {
    // Private reference to the singleton user
    static let globalUser: User = User()
    @Published var shazamRequestHistory: [SHMediaItem]
    
    // Private constructor to ensure client can't create new Users (singleton)
    private init(shazamRequestHistory: [SHMediaItem] = []) {
        self.shazamRequestHistory = shazamRequestHistory
    }
    
    func getShazamRequestHistory() -> [SHMediaItem] {
        return shazamRequestHistory
    }
    
    func addMediaToShazamHistory(item: SHMediaItem?) {
        guard let item = item else {
            return
        }
        shazamRequestHistory.append(item)
    }
}
