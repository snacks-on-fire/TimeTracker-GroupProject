//
//  TimeTrackerApp.swift
//  TimeTracker
//
//  Created by Dalia Maraoulaite on 7/24/21.
//

import SwiftUI

@main
struct TimeTrackerApp: App {
    @StateObject var task = Task()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(task)
        }
    }
}
