//
//  TaskSession.swift
//  TimeTracker
//
//  Created by Dalia Maraoulaite on 7/25/21.
//

import Foundation

class TaskSession: Identifiable, ObservableObject {
    
    @Published var id: UUID
    @Published var fromDate: Date
    @Published var toDate: Date
    @Published var delta: TimeInterval
    @Published var notes: String
    
    init() {
        id = UUID()
        fromDate = Date()
        toDate = Date()
        delta = 0
        notes = ""
    }
}
