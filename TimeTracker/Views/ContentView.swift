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
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Add a task", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                List {
                    ForEach(tasks.items) { item in
                        NavigationLink(
                            // "task" only appears once on this screen because that's the name of the variable that is passed to the next screen
                            // that is, "task == tasks[item]" is True
                            // This next appears in the receiver in TaskTimerView_Previews
                            destination: TaskTimerView(task: item),
//                            label: {Text("Text")})
                            label: {Text(item.name)})
                    }.onDelete(perform: removeItems)
                }
            }.navigationBarTitle(rootWord)
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
        tasks.items.insert(newTask, at: 0)

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
