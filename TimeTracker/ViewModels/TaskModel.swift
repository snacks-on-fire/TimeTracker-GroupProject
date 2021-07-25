//
//  TaskModel.swift
//  TimeTracker
//
//  Created by Dalia Maraoulaite on 7/24/21.
//

import Foundation

class TaskModel:ObservableObject {
    
    // Properties
    @ Published var tasks = [Task]()
    // tasks is the same array as data = [Task]() created in the ContentView
    
    /*
    // Method
    init() {
        
        // Create an instance of data service and get the data
    /*
        let service = DataService()
        self.recipes = service.getLocalData()
    */
        
        // Some random piece of code to initialize the ViewModel
        tasks.append(Task(name: "Task 1"))
    }
     
     // Turns out, this code isn't needed at all! :)
     
     */
}
