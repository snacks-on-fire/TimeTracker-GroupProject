//
//  TaskTimerView.swift
//  TimeTracker
//
//  Created by Dalia Maraoulaite on 7/24/21.
//

import SwiftUI

struct TaskTimerView: View {
    
    // Properties
    
    // Property task of type Task. This property does not have an initial value.
    // This way the memberwise initializer init(task:) is automatically created.
    // The value is passed to the task property from ContentView.
    @State var task: Task
//    @ObservedObject var tasks = TaskModel()
    
    @State var session = TaskSession()
    @ObservedObject var sessions = SessionModel()
    
    @State var buttons = Buttons()
    @ObservedObject var buttonsModel = ButtonsModel()
    
    // @State property wrapper allows us to change the values
    // i.e. w/o the @State property wrapper, the values are immutable
    @State var tabIndex = 1
    
    @State var fromDateString = ""
    @State var toDateString = ""
    @State var deltaString = ""
    @State var totalTimeString = ""
    @State var saveMessage = ""
    
    var body: some View {
        TabView(selection: $tabIndex) {
            
            VStack (alignment: .center) {
                
                VStack {
                    Text("This is the Timer View for \(task.name)")
                    // Text("This is the Timer View for \(task.id)")
                    Text("The total time for \(task.name) is \(sessions.getDelta(intervalValue: task.totalTime)).")
                    Text("Add Ticking Timer Label Here \n 00:00:00").multilineTextAlignment(.center).padding()
                }
                
                HStack {
                    Button("START") {
                        
                        // Get the value of the start date (time)
                        session.fromDate = Date()
                        
                        /*
                        // To test the code, try a date in the past (for fromDate)
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MM/dd/yyyy"
                        session.fromDate = (dateFormatter.date(from: "07/15/2021"))!
                        */

                        // Save as string
                        fromDateString = ("Session start: " + sessions.getDateTime(dateValue: session.fromDate))
                        
                        buttons.startB = true
                        buttons.stopB = false
                        buttons.resetB = false
                        buttons.saveB = false
                    }.padding()
                    .disabled(buttons.startB == false)
                    
                    Button("STOP") {
                        
                        // Get the value of the end date (time)
                        session.toDate = Date()
                        // Calculate session duration as TimeInterval() which is a Double
                        session.delta = session.toDate.timeIntervalSince1970 - session.fromDate.timeIntervalSince1970

                        
                        // Save as string
                        toDateString = ("Session end: " + sessions.getDateTime(dateValue: session.toDate))
                        deltaString = ("Session duration: " + sessions.getDelta(intervalValue: session.delta))
                        
                        buttons.startB = false
                        buttons.stopB = false
                        buttons.resetB = true
                        buttons.saveB = true
                    }.padding()
                    .disabled(buttons.stopB == false)
                    
                    Button("SAVE") {
                        // The two lines of code below mean the same thing and both work equally well:
//                        task.taskSessions?.append(session)
                        sessions.items.append(session)
                        // THIS (below) statement makes the app crash:
//                        sessionsQuantity = (task.taskSessions?[0].name)!

//                        let a = task.sessions?.count
                        task.totalTime += session.delta
                        saveMessage = "Session info saved successfully - this sh/could be an Alert."
                        // totalTimeString = ("Total time spent on \(task.name) is \(sessions.getDelta(intervalValue: task.totalTime))")
                        totalTimeString = ("Total time is \(sessions.getDelta(intervalValue: task.totalTime))")
                        
                        buttons.startB = true
                        buttons.stopB = false
                        buttons.resetB = false
                        buttons.saveB = false
                    }.padding()
                    .disabled(buttons.saveB == false)
                    
                    Button("RESET") {
                        // Add code to delete session
                        fromDateString = ""
                        toDateString = ""
                        deltaString = ""
                        saveMessage = ""
                        buttons.startB = true
                        buttons.stopB = false
                        buttons.resetB = false
                        buttons.saveB = false
                    }.padding()
                    .disabled(buttons.resetB == false)
                    
                }.padding()
                
                VStack {
                    Text(fromDateString)
                    Text(toDateString)
                    Text(deltaString)
                    Text(saveMessage)
                    Text(totalTimeString)
                    Text("Sessions saved for \(task.name): " + String(sessions.items.count))
                }.multilineTextAlignment(.center).padding()
                
                List(0..<sessions.items.count) { item in
                    Text("Hello, item \(item).")
                }
                    
                    /*
                    {
                    ForEach(sessions.items, id: \.id) { item in
                        NavigationLink(
                            // "task" only appears once on this screen because that's the name of the variable that is passed to the next screen
                            // that is, "task == tasks[item]" is True
                            // This next appears in the receiver in TaskTimerView_Previews
                            destination: SessionInfoView(session: item),
//                            label: {Text("Text")})
                            label: {Text("Text")})
                    }.onDelete(perform: removeItems)
                }
                
                
//                let sessionsArray: [TaskSession] = (task.taskSessions)!
//                List (sessionsArray, id: \.id) { item in
//                    Text(item.getDateTime(dateValue: item.toDate))
//                }
//                List {

                    ForEach(sessionsArray) { item in
                        NavigationLink(
                            // "task" only appears once on this screen because that's the name of the variable that is passed to the next screen
                            // that is, "task == tasks[item]" is True
                            // This next appears in the receiver in TaskTimerView_Previews
                            destination: SessionInfoView(session: item),
//                            label: {Text("Text")})
                            label: {Text("Menu label")}) // item.name
                    }.onDelete(perform: removeItems)  */
//                }
                
            }
            .tabItem {
                VStack {
                    Image(systemName: "clock")
                    Text("Start Timer")
                }}.tag(1)
            
            VStack {
                Text("This is the Picker view for \(task.name)")
                Text("This is some more text.")
            }
            .tabItem {
                VStack {
                    Image(systemName: "clock.fill")
                    Text("Add a session")
                }}.tag(2)
            
        }.navigationBarTitle(task.name)
    }
}
    
    
/*    func removeItems(at offsets: IndexSet) {
        sessions.items.remove(atOffsets: offsets)
    } */


#if DEBUG
struct TaskTimerView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        // The preview needs a value to initialize the task:Task property
        TaskTimerView(task: Task())
    }
}
#endif
