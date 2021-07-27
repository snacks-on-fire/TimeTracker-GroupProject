//
//  TaskModel.swift
//  TimeTracker
//
//  Created by Dalia Maraoulaite on 7/24/21.
//

import Foundation

class TaskModel: ObservableObject {

    @Published var items = [Task]()

}
