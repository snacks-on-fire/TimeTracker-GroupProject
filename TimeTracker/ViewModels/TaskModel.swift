//
//  TaskModel.swift
//  TimeTracker
//
//  Created by Dalia Maraoulaite on 7/24/21.
//

import Foundation

class TaskModel:ObservableObject {
    
    @ Published var tasks = [Task]()
    
    init() {
        
        // Create an instance of data service and get the data
    /*
        let service = DataService()
        self.recipes = service.getLocalData()
    */
        
        tasks.append(Task(name: "Task 1", nameName: "Task 1*"))
        tasks.append(Task(name: "Task 2", nameName: "Task 2*"))
        tasks.append(Task(name: "Task 3", nameName: "Task 3*"))
    }
}
