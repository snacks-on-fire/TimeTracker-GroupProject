//
//  SessionModel.swift
//  TimeTracker
//
//  Created by Dalia Maraoulaite on 7/25/21.
//

import Foundation

class SessionModel: ObservableObject {
    
    @ Published var sessions = [Session]()
    
    // Methods
    
    // This function converts Date() to String
    func getDateTime(dateValue: Date) -> (String) {
        // Initializes the date and time formatter and sets the style:
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter.string(from: dateValue)
    }
    
    // This function converts TimeInterval() to String
    func getDelta(intervalValue: TimeInterval) -> (String) {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.includesApproximationPhrase = false
        formatter.includesTimeRemainingPhrase = false
        // formatter.allowedUnits = [.minute]
        return formatter.string(from: intervalValue)!
    }
}
