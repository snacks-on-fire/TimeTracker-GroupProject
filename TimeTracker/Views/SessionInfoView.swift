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
    
    @State var sessionsArray = [TaskSession]()
    
    @State var fromDateString = ""
    @State var toDateString = ""
    @State var deltaString = ""
    @State var totalTimeString = ""
    @State var notes = ""
    @State var sessionIndex: Int = 0
        
    var body: some View {
        
        VStack {
            
            List{
                Text(fromDateString)
                Text(toDateString)
                Text(deltaString)
                Text(totalTimeString)
                Text("sessionIndex: " + String(sessionIndex)).foregroundColor(.red)
            }.onAppear { self.getSessionInfo() }
            
            
            Form {
                Text("Notes")
                    .font(.callout)
                    .bold()
                TextEditor(text: $session.notes) //, onCommit: save)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
            }
            
            VStack(alignment: .leading) {

            }.padding()
        }
    }
    
    func save() {
        task.taskSessions?.remove(at: sessionIndex)
        task.taskSessions?.insert(session, at: sessionIndex)
    }
    
    func getSessionInfo() {
        
        // Determine the index of the selected session in the task.taskSessions array
        guard let index = task.taskSessions?.firstIndex(where: {$0.id == session.id}) else {
            print("Could not find the given UUID")
            return
        }
        
        // Convert the weird type into an integer using the extention at the bottom of the page
        sessionIndex = task.taskSessions?.distance(to: index) ?? 0
        
        // Get session info for the TaskSession instance
        if let y = task.taskSessions {
            sessionsArray = y

            fromDateString = ("Session start: " + sessions.getDateTime(dateValue: sessionsArray[index].fromDate))
            toDateString = ("Session end: " + sessions.getDateTime(dateValue: sessionsArray[index].toDate))
            deltaString = ("Session length: " + sessions.getDelta(intervalValue: sessionsArray[index].delta))
        }
        
        totalTimeString = ("Total time recorded for \(task.name): \(sessions.getDelta(intervalValue: task.totalTime))")
    }
}

struct SessionInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SessionInfoView(task: Task(), session: TaskSession())
    }
}

extension Collection {
    func distance(to index: Index) -> Int { distance(from: startIndex, to: index) }
}
