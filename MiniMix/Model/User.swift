//
//  User.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/6/23.
//

import Foundation
import ShazamKit

// Custom Singleton User class to track a constant instance of the user's Shazam Request History
class User: ObservableObject {
    
    // Global reference to the single user instance
    static let globalUser: User = User()
    
    // List of user's song requests -> must be accessed via getter
    // Published enables HistoryView to check for updates to the list
    @Published private var shazamRequestHistory: [BinarySong]
    
    // Private constructor to ensure client can't create new Users
    private init(shazamRequestHistory: [BinarySong] = []) {
        self.shazamRequestHistory = shazamRequestHistory
    }
    
    // Getter for User's Shazam Request History
    func getShazamRequestHistory() -> [BinarySong] {
        return shazamRequestHistory
    }
    
    // Adds given song to the User's Shazam Request History
    func addMediaToShazamHistory(item: BinarySong?) {
        guard let item = item else {
            return
        }
        shazamRequestHistory.append(item)
    }
}
