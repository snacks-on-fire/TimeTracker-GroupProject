//
//  Task.swift
//  TimeTracker
//
//  Created by Dalia Maraoulaite on 7/24/21.
//

import Foundation

class Task: Identifiable, ObservableObject {
    
    var id: UUID
    var name: String
    var taskSessions: [TaskSession]
    var totalTime: TimeInterval
    
    var startB: Bool
    var stopB: Bool
    var resetB: Bool
    var saveB: Bool
    
    init() {
        id = UUID()
        name = ""
        taskSessions = []
        totalTime = 0 // Double()
        
        startB = true
        stopB = false
        resetB = false
        saveB = false
    }
}
