//
//  SessionInfoView.swift
//  TimeTracker
//
//  Created by Dalia Maraoulaite on 7/26/21.
//

import SwiftUI

struct SessionInfoView: View {
    
    // Property task of type Task. This property does not have an initial value.
    // This way the memberwise initializer init(task:) is automatically created.
    // The value is passed to the task property from ContentView.
    @State var task: Task
    @State var session: TaskSession
    @ObservedObject var sessions = SessionModel()
    
    @State var fromDateString = ""
    @State var toDateString = ""
    @State var deltaString = ""
    @State var totalTimeString = ""
        
    var body: some View {
        
        List{
            Text(fromDateString)
            Text(toDateString)
            Text(deltaString)
            Text(totalTimeString)
        }.onAppear { self.getSessionInfo() }
    }
    
    func getSessionInfo() {
        fromDateString = ("Session start: " + sessions.getDateTime(dateValue: session.fromDate))
        toDateString = ("Session end: " + sessions.getDateTime(dateValue: session.toDate))
        deltaString = ("Last session duration: " + sessions.getDelta(intervalValue: session.delta))
        totalTimeString = ("Total time for \(task.name): \(sessions.getDelta(intervalValue: task.totalTime))")
    }
}

struct SessionInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SessionInfoView(task: Task(), session: TaskSession())
    }
}
