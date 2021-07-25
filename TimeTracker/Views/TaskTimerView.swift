//
//  TaskTimerView.swift
//  TimeTracker
//
//  Created by Dalia Maraoulaite on 7/24/21.
//

import SwiftUI

struct TaskTimerView: View {
    
    // Properties
    
    // Property task of type Task.
    // This property does not have an initial value.
    // An initializer init(task:) is automatically created for us; it’s the memberwise initializer.
    @State var task: Task
    
    // @State property wrapper allows us to change the values
    // i.e. w/o the @State property wrapper, the values are immutable
    @State var tabIndex = 1
    
    @State var fromDateString = ""
    @State var toDateString = ""
    @State var deltaString = ""
    @State var totalTimeString = ""
    @State var saveMessage = ""
    @State var startB = true
    @State var stopB = false
    @State var resetB = false
    @State var saveB = false
    
    @State var session = Session()
    let model = SessionModel()
    
    var body: some View {
        TabView(selection: $tabIndex) {
            
            VStack (alignment: .center) {
                Text("This is the Timer View for \(task.name)")
                Text(" ")
                
                Text("Add Ticking Timer Label Here \n 00:00:00").multilineTextAlignment(.center).padding()
                
                HStack {
                    Button("START") {
                        
                        // Get the value of the start date (time)
                        session.fromDate = Date()
                        
                        /*
                        // To test the code, try a date in the past (for fromDate)
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MM/dd/yyyy"
                        session.fromDate = (dateFormatter.date(from: "03/15/1998"))!
                        */

                        // Save as string
                        fromDateString = ("Session start: " + model.getDateTime(dateValue: session.fromDate))
                        
                        startB = false
                        stopB = true
                        resetB = true
                        saveB = false
                    }.padding()
                    .disabled(startB == false)
                    
                    Button("STOP") {
                        
                        // Get the value of the end date (time)
                        session.toDate = Date()
                        // Calculate session duration as TimeInterval() which is a Double
                        session.delta = session.toDate.timeIntervalSince1970 - session.fromDate.timeIntervalSince1970

                        
                        // Save as string
                        toDateString = ("Session end: " + model.getDateTime(dateValue: session.toDate))
                        deltaString = ("Session duration: \n" + model.getDelta(intervalValue: session.delta))
                        
                        startB = false
                        stopB = false
                        resetB = true
                        saveB = true
                    }.padding()
                    .disabled(stopB == false)
                    
                    Button("SAVE") {
                        task.sessions?.append(session)
//                        let a = task.sessions?.count
                        task.totalTime += session.delta
                        saveMessage = "Session info saved successfully."
                        totalTimeString = ("Total time spent on \(task.name) is \(model.getDelta(intervalValue: task.totalTime))")
                        
                        startB = true
                        stopB = false
                        resetB = false
                        saveB = false
                    }.padding()
                    .disabled(saveB == false)
                    
                    Button("RESET") {
                        // Add code to delete session
                        fromDateString = ""
                        toDateString = ""
                        deltaString = ""
                        saveMessage = ""
                        startB = true
                        stopB = false
                        resetB = false
                        saveB = false
                    }.padding()
                    .disabled(resetB == false)
                    
                }.padding()
                
                Text(fromDateString).padding()
                Text(toDateString).padding()
                Text(deltaString).multilineTextAlignment(.center).padding()
                Text(saveMessage)
                Text(totalTimeString)
                
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

struct TaskTimerView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        // The TaskTimerView_Preview creates an instance of the TaskModel
        let viewModel = TaskModel()
        // and passes task == data[item], which is an instance of Task() created on the CotentView, to the ViewModel into the tasks array at position 0
        TaskTimerView(task: viewModel.tasks[0])
        
    }
}
