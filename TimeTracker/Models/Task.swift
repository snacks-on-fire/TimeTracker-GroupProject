//
//  Task.swift
//  TimeTracker
//
//  Created by Dalia Maraoulaite on 7/24/21.
//

import Foundation

class Task: Identifiable {
    
    var id = UUID()
    var name: String = ""
    var sessions: [Session]?
    var totalTime: Double = Double()

}
