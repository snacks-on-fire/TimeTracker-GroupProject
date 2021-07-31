//
//  Task.swift
//  TimeTracker
//
//  Created by Dalia Maraoulaite on 7/24/21.
//

import Foundation

class Task: Identifiable, ObservableObject {
    
    @Published var id: UUID
    @Published var name: String
    @Published var taskSessions: [TaskSession]
    @Published var totalTime: TimeInterval
    
    @Published var startB: Bool
    @Published var stopB: Bool
    @Published var resetB: Bool
    @Published var saveB: Bool
    
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
