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
    @ObservedObject var tasks = TaskModel() //***
    
    @State var session = TaskSession()
    @ObservedObject var sessions = SessionModel()
    
    // @State property wrapper allows us to change the values
    // i.e. w/o the @State property wrapper, the values are immutable
    @State var tabIndex = 1
    
    @State var fromDateString = ""
    @State var toDateString = ""
    @State var deltaString = ""
    @State var totalTimeString = ""
    @State var saveMessage = ""
    @State var sessionsCount: Int = 0
    @State var debugMessage = ""
    @State var counter = 0
    
    var body: some View {
        TabView(selection: $tabIndex) {
            
            VStack (alignment: .center) {
                
                VStack {
                
                    VStack {
                        // Text("This is the Timer View for \(task.name)")
                        // Text("This is the Timer View for \(task.id)")
                        // Text("Total time for \(task.name) is \(sessions.getDelta(intervalValue: task.totalTime)).")
                        Text("Add Ticking Timer Label Here").foregroundColor(.red)
                        Text("00:00:00")
                    }.multilineTextAlignment(.center).padding()
                    
                    HStack {
                        Button("START") {
                            // Get the value of the start date (time)
                            // Create an instance of TaskSession & give it a name. Append to task.taskSessions
                            let newSession = TaskSession()
                            session = newSession
                            session.fromDate = Date()
                            
                            /*
                            // To test the code, try a date in the past (for fromDate)
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "MM/dd/yyyy"
                            session.fromDate = (dateFormatter.date(from: "07/15/2021"))!
                            //                                                     _      _
                            // Actually, this does not work anymore for some reason \("/)/
                             
                             */

                            // Save as string
                            fromDateString = ("Session start: " + sessions.getDateTime(dateValue: session.fromDate))
    //                        fromDateString = ("Session start: " + sessions.getDateTime(dateValue: session.fromDate))
                            
    /*                        if task.taskSessions?.count ?? 0 == 0 {
                                sessionsCount = 0
                            } else {
                                sessionsCount = (task.taskSessions?.count)! - 1
                            }
    */
                            task.startB = false
                            task.stopB = true
                            task.resetB = true
                            task.saveB = false
                        }.padding()
                        .disabled(task.startB == false)
                        
                        Button("STOP") {
                            
                            // Get the value of the end date (time)
                            session.toDate = Date()
                            // Calculate session duration as TimeInterval() which is a Double
                            session.delta = (session.toDate.timeIntervalSince1970) - (session.fromDate.timeIntervalSince1970)

                            // Save as string
                            toDateString = ("Session end: " + sessions.getDateTime(dateValue: session.toDate))
                            deltaString = ("Last session duration: " + sessions.getDelta(intervalValue: session.delta))
                            
                            task.startB = false
                            task.stopB = false
                            task.resetB = true
                            task.saveB = true
                        }.padding()
                        .disabled(task.stopB == false)
                        
                        Button("SAVE") {
                            
                            save()
                            
    //                        sessionsCount = task.taskSessions?.count ?? 0
                            // The two lines of code below mean the same thing and both work equally well:
                            // No, they don't. Sessions.items is a temporary storage, while task.taskSessions saves session info and moves it between screens
    //                        task.taskSessions?.append(session)
    //                        sessions.items.append(session)
                            // THIS (below) statement makes the app crash:
    //                        sessionsQuantity = (task.taskSessions?[0].name)!

    //                        let a = task.sessions?.count
                            task.totalTime += (session.delta)
                            // totalTimeString = ("Total time spent on \(task.name) is \(sessions.getDelta(intervalValue: task.totalTime))")
                            totalTimeString = ("Total time for \(task.name): \(sessions.getDelta(intervalValue: task.totalTime))")
                            
                            task.startB = true
                            task.stopB = false
                            task.resetB = false
                            task.saveB = false
                        }.padding()
                        .disabled(task.saveB == false)
                        
                        Button("RESET") {
                            // Add code to delete session
    //                        if task.taskSessions?.count ?? 0 > 0 {
    //                            sessions.items.removeLast()
    //                        }
                            fromDateString = ""
                            toDateString = ""
                            deltaString = ""
                            saveMessage = ""
                            task.startB = true
                            task.stopB = false
                            task.resetB = false
                            task.saveB = false
                        }.padding()
                        .disabled(task.resetB == false)
                        
                    }.padding()
                    
                    VStack {
                        Text(fromDateString).foregroundColor(.red)
                        Text(toDateString).foregroundColor(.red)
                        Text(deltaString).foregroundColor(.red)
                        Text(totalTimeString).foregroundColor(.red)
//                        Text("\(String(task.taskSessions?.count ?? 0)) sessions saved to task.taskSessions?.")
//                        Text("\(String(sessions.items.count)) sessions saved to sessions.items.")
                        // The debugMessage is needed to keep the screen up-to-date :(
                        // Looking for a fix.
                        Text(debugMessage)
                    }.multilineTextAlignment(.center).padding()
                }
                
                VStack {
                    
                    List{
                        // Unwrapping task.taskSessions? via optional binding
                        if let x = task.taskSessions {
                            let sessionsArray = x
                            ForEach(sessionsArray, id: \.id) { item in
                                NavigationLink(
                                    destination: SessionInfoView(task: task, session: item),
                                    label: {
                                        Text("\(sessions.getDateTime(dateValue: item.fromDate))")
//                                        Text("\(String(sessionsArray.count))") returns item number
//                                        Text("\(String(sessions.items.count))") returns 0
//                                        Text("\(String(task.taskSessions?.count ?? 0))") returns item number
                                    })
                            }.onDelete(perform: removeItems)
                        }
                    }
                    
//                    List {
//                        ForEach(sessions.items, id: \.id) { item in
//                            NavigationLink(
//                                destination: SessionInfoView(session: item),
//                                label: {
//                                    Text("Go to: \(sessions.getDateTime(dateValue: item.fromDate)).")
//                                })
//                        }.onDelete(perform: removeItems)
//                    }
                }
            }
            .tabItem {
                VStack {
                    Image(systemName: "clock")
                    Text("Start Timer")
                }}.tag(1)
            
            
            
            
            VStack {
                Text("This is the Picker view for \(task.name)").foregroundColor(.red)
                Text("This is some more text.").foregroundColor(.red)
            }
            .tabItem {
                VStack {
                    Image(systemName: "clock.fill")
                    Text("Add a session")
                }}.tag(2)
            
            
            
            
        }.navigationBarTitle(task.name)
    }
    
    func removeItems(at offsets: IndexSet) {
        task.taskSessions?.remove(atOffsets: offsets)
        
        // Leave this in, the changing debugMessage forces the View to update...
        counter += 1
        debugMessage = "You removed \(String(counter)) sessions."
    }
    
    func save() {
        task.taskSessions?.append(session)
    }
    
}

#if DEBUG
struct TaskTimerView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        // The preview needs a value to initialize the task:Task property
        TaskTimerView(task: Task())
    }
}
#endif
