//
//  ContentView.swift
//  TimeTracker
//
//  Created by Dalia Maraoulaite on 7/24/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var tasks = TaskModel()
    @State private var rootWord = "Tasks"
    @State private var newWord = ""
    
    @State var task = Task()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Add a task", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                List {
                    ForEach(tasks.items, id: \.id) { item in
                        NavigationLink(
                            // TaskTimerView is expecting a task object of type Task()
                            // tasks.items[item] == item is passed to the task property in the TaskTimerView
                            // Make sure the task is also passed in TaskTimerView_Previews to preview that View
                            destination: TaskTimerView(task: item),
                            label: {Text(item.name)})
                    }.onDelete(perform: removeItems)
                }
            }.navigationBarTitle(rootWord, displayMode: .automatic)
        }
    }

    func addNewWord() {
        // Format the newWord
        let answer = newWord.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Make sure it has more than 0 characters
        guard answer.count > 0 else {
            return
        }
        
        // Create an instance of Task & give it a name. Append to tasks
        let newTask = Task()
        newTask.name = answer
        task = newTask
        tasks.items.insert(task, at: 0)

        newWord = ""
    }
    
    func removeItems(at offsets: IndexSet) {
        tasks.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// https://www.hackingwithswift.com/books/ios-swiftui/adding-to-a-list-of-words

// MVVM model use
// https://www.hackingwithswift.com/books/ios-swiftui/building-a-list-we-can-delete-from
// UUID https://www.hackingwithswift.com/books/ios-swiftui/working-with-identifiable-items-in-swiftui

// Archiving Swift objects with Codable
// https://www.hackingwithswift.com/books/ios-swiftui/archiving-swift-objects-with-codable
