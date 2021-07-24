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
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Add a task", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                List (0..<usedWords.count, id: \.self) { item in
                    NavigationLink(destination: TaskTimerView()) {
                    Text(usedWords[item])
                    }
                }.navigationBarTitle(rootWord)
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
