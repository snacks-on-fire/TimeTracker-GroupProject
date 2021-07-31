//
//  ContentView.swift
//  TimeTracker
//
//  Created by Dalia Maraoulaite on 7/24/21.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    
    @ObservedObject var tasks = TaskModel()
    @ObservedObject var sessions = SessionModel()
    @State private var rootWord = "Tasks"
    @State private var newWord = ""
        
    @State var task = Task()
    @State var tabIndex = 1
    @State var totalTimeArray: [TimeInterval] = []
    
    var body: some View {
            
        NavigationView {
            
            TabView(selection: $tabIndex) {
                
                VStack {
//                     TextEditor(text: $task.name).onAppear { self.addNewTask() }
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
                    }.environmentObject(task)
                }
                .tabItem {
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("Task List")
                    }
                }.tag(1)
            
                VStack {
                    
                    VStack {
                        Text("This is the Charts and Graphs view.").foregroundColor(.red)
                        PieChartView(data: totalTimeArray, title: "Title", legend: "Legendary") // legend is optional
                    }
                    List{
                        HStack{
                            Text("Task title:   ")
                            Text("Total time")
                        }
                        ForEach(tasks.items, id: \.id) { item in
                            HStack{
                                Text(item.name + ":   ")
                                Text(sessions.getDelta(intervalValue: item.totalTime))
                            }
                        }
                    }.onAppear { self.getTotalTimeArray() }
                }
                .tabItem {
                    VStack {
                        Image(systemName: "chart.pie")
                        Text("Statistics")
                    }
                }.tag(2)
            }.navigationBarTitle(rootWord, displayMode: .automatic)
        }
    }
    
    func getTotalTimeArray() {
        for index in 0...tasks.items.count-1 {
            totalTimeArray.append(tasks.items[index].totalTime)
        }
    }
    
//    func addNewTask() {
//
//        // Create an instance of Task & give it a name. Append to tasks
//        let newTask = Task()
//        newTask.name = task.name
//        tasks.items.insert(newTask, at: 0)
//
//        newWord = ""
//    }
    
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

public extension Binding where Value: Equatable {
    init(_ source: Binding<Value?>, replacingNilWith nilProxy: Value) {
        self.init(
            get: { source.wrappedValue ?? nilProxy },
            set: { newValue in
                if newValue == nilProxy {
                    source.wrappedValue = nil
                }
                else {
                    source.wrappedValue = newValue
                }
        })
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



