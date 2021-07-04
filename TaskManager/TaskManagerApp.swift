//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Данил ОТК on 25.06.2021.
//

import SwiftUI
import RealmSwift

let realm = try! Realm()

@main
struct TaskManagerApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
