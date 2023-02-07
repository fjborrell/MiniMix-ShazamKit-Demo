//
//  DateAndTime.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/7/23.
//

import Foundation

extension TimeInterval {
    // Return a TimeInterval formatted as a "00:00" String
    func stringFormatted() -> String {
        let interval = Int(self)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

extension Date {
    // Return a Date formatted as a "Month Day, Year" String (e.g. February 7, 2023)
    func stringFormatted() -> String {
        let date = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, YYYY"
        return dateFormatter.string(from: date)
    }
}
