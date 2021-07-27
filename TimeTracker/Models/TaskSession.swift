//
//  TaskSession.swift
//  TimeTracker
//
//  Created by Dalia Maraoulaite on 7/25/21.
//

import Foundation

class TaskSession: Identifiable {
    
    var id: UUID
    var fromDate: Date
    var toDate: Date
    var delta: TimeInterval
    var notes: String
    
    init() {
        id = UUID()
        fromDate = Date()
        toDate = Date()
        delta = 0
        notes = ""
    }
}
