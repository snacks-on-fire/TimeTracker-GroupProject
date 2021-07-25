//
//  ContentView.swift
//  TimeTracker
//
//  Created by Dalia Maraoulaite on 7/24/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = "Tasks"
    @State private var newWord = ""
    @State var data = [Task]()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Add a task", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                List (0..<usedWords.count, id: \.self) { item in
                    NavigationLink(
                        // Note that "task" only appears once on this screen.
                        // This is because that's the name of the variable that is passed to the next screen
                        // that is, "task == data[item]" is True
                        // This next appears in the receiver in TaskTimerView_Previews
                        destination: TaskTimerView(task: data[item]),
                        // either this statement or the following is fine
                        // because usedWords[item] is the same as data[item].name
                        // label: {Text(usedWords[item])})
                        label: {Text(String(data[item].name))})
                }
                Text(String(data.count))
            }.navigationBarTitle(rootWord)
        }
    }

    func addNewWord() {
        let answer = newWord.trimmingCharacters(in: .whitespacesAndNewlines)

        guard answer.count > 0 else {
            return
        }
        
        usedWords.insert(answer, at: 0)
        data.insert(Task(name: answer), at: 0)
        newWord = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// https://www.hackingwithswift.com/books/ios-swiftui/adding-to-a-list-of-words

