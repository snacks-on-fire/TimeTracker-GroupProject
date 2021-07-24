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
    
    var body: some View {
        VStack {
            Text(task.name)
            Text(task.nameName!)
        }
    }
}


struct TaskTimerView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let viewModel = TaskModel()
        TaskTimerView(task: viewModel.tasks[0])
        
    }
}
