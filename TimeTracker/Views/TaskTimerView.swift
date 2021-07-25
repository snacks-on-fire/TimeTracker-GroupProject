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
    @ObservedObject var tasks = TaskModel()
    
    @State var session = Session()
    @ObservedObject var model = SessionModel()
    //    let model = SessionModel()
    
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
                Text("This is the Timer View for \(task.name)")
//                Text("This is the Timer View for \(task.id)")
                Text("The total time for \(task.name) is \(model.getDelta(intervalValue: task.totalTime)).")
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
                        
                        buttons.startB = false
                        buttons.stopB = true
                        buttons.resetB = true
                        buttons.saveB = false
                    }.padding()
                    .disabled(buttons.startB == false)
                    
                    Button("STOP") {
                        
                        // Get the value of the end date (time)
                        session.toDate = Date()
                        // Calculate session duration as TimeInterval() which is a Double
                        session.delta = session.toDate.timeIntervalSince1970 - session.fromDate.timeIntervalSince1970

                        
                        // Save as string
                        toDateString = ("Session end: " + model.getDateTime(dateValue: session.toDate))
                        deltaString = ("Session duration: \n" + model.getDelta(intervalValue: session.delta))
                        
                        buttons.startB = false
                        buttons.stopB = false
                        buttons.resetB = true
                        buttons.saveB = true
                    }.padding()
                    .disabled(buttons.stopB == false)
                    
                    Button("SAVE") {
                        task.sessions?.append(session)
//                        let a = task.sessions?.count
                        task.totalTime += session.delta
                        saveMessage = "Session info saved successfully."
                        totalTimeString = ("Total time spent on \(task.name) is \(model.getDelta(intervalValue: task.totalTime))")
                        
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
                
                Text(fromDateString).padding()
                Text(toDateString).padding()
                Text(deltaString).multilineTextAlignment(.center).padding()
                Text(saveMessage)
//                Text(totalTimeString)
                
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

#if DEBUG
struct TaskTimerView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        // The preview needs a value to initialize the task: Task property
        TaskTimerView(task: Task())
        
    }
}
#endif

/*
class TaskModel: ObservableObject {

    @ Published var items = [Task]()

}
*/
