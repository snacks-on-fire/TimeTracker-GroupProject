//
//  TaskTimerView.swift
//  TimeTracker
//
//  Created by Dalia Maraoulaite on 7/24/21.
//

import SwiftUI

struct TaskTimerView: View {
    // property task of type Task
    // this property does not have an initial value
    // an initializer init(task:) is automatically created for us; it’s the memberwise initializer.
    var task: Task
    
    @State var tabIndex = 1
    
    var body: some View {
        TabView(selection: $tabIndex) {
            Text("This is the Timer View for \(task.name)")
                .tabItem {
                    VStack {
                        Image(systemName: "clock")
                        Text("Start Timer")
                    }
                }.tag(1)
            VStack {
                Text("This is the Picker view for \(task.name)")
                Text("This is some more text.")
            }
            .tabItem {
                VStack {
                    Image(systemName: "clock.fill")
                    Text("Add a session")
                }
            }.tag(2)
    
        }.navigationBarTitle(task.name)
        
    }
}


struct TaskTimerView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let viewModel = TaskModel()
        TaskTimerView(task: viewModel.tasks[0])
        
    }
}
