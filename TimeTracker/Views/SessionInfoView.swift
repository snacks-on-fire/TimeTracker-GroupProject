//
//  SessionInfoView.swift
//  TimeTracker
//
//  Created by Dalia Maraoulaite on 7/26/21.
//

import SwiftUI

struct SessionInfoView: View {
    
    // Property task of type Task. This property does not have an initial value.
    // This way the memberwise initializer init(task:) is automatically created.
    // The value is passed to the task property from ContentView.
    @State var session: TaskSession
    
    var body: some View {
        Text("Hello, world!")
    }
}

struct SessionInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SessionInfoView(session: TaskSession())
    }
}
