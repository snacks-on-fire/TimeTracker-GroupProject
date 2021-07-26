//
//  TaskSession.swift
//  TimeTracker
//
//  Created by Dalia Maraoulaite on 7/25/21.
//

import Foundation

class TaskSession: Identifiable {
    
    var id = UUID()
    var name = "TaskSession Name"
    var fromDate = Date()
    var toDate = Date()
    var delta: TimeInterval = 0
    
}
