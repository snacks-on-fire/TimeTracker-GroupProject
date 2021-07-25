//
//  Session.swift
//  TimeTracker
//
//  Created by Dalia Maraoulaite on 7/25/21.
//

import Foundation

struct Session: Identifiable {
    
    var id = UUID()
    var fromDate = Date()
    var toDate = Date()
    var delta: TimeInterval = 0
    
}
