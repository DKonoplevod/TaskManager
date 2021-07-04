//
//  AddTaskView.swift
//  TaskManager
//
//  Created by Данил ОТК on 26.06.2021.
//

import SwiftUI

struct AddTaskView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let isCreatedTask : Bool
    var task : Task?
    
    @State private var nameText : String
    @State private var descriptionText : String
    @State private var priorityIndex : Priority
    @State private var isDeadline : Bool
    @State private var deadLineDate : Date
    @State private var dateFrom : Date
    @State private var dateTo : Date
    
    init() {
        self._nameText = .init(initialValue: "")
        self._descriptionText = .init(initialValue: "")
        self._priorityIndex = .init(initialValue: Priority.none)
        self._isDeadline = .init(initialValue: false)
        self._deadLineDate = .init(initialValue: Date())
        self._dateFrom = .init(initialValue: Date())
        self._dateTo = .init(initialValue: Date())
        self.isCreatedTask = false
    }
    
    init(task : Task) {
        self._nameText = .init(initialValue: task.name)
        self._descriptionText = .init(initialValue: task.notes)
        self._priorityIndex = .init(initialValue: task.priority)
        self._isDeadline = .init(initialValue: task.isDeadline)
        self._dateFrom = .init(initialValue: task.dateFrom as Date)
        self._dateTo = .init(initialValue: task.dateTo as Date)
        self._deadLineDate = .init(initialValue: task.deadline as Date)
        self.isCreatedTask = true
        self.task = task
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $nameText)
                TextEditor(text: $descriptionText)
            }
            
            Section {
                Picker(selection: $priorityIndex, label: Text("Priority"), content: {
                    Text("None").tag(Priority.none)
                    Text("Low").tag(Priority.low)
                    Text("Medium").tag(Priority.medium)
                    Text("High").tag(Priority.high)
                })
            }
            
            Section {
                Toggle("Deadline", isOn: $isDeadline)
            }
            
            if(isDeadline)
            {
                Section {
                    DatePicker("Do until", selection: $deadLineDate, displayedComponents: [.date, .hourAndMinute])
                }
            }
            else
            {
                Section {
                    DatePicker("From", selection: $dateFrom, displayedComponents: [.date, .hourAndMinute])
                    DatePicker("To", selection: $dateTo, displayedComponents: [.date, .hourAndMinute])
                }
            }
            
            Section {
                Button(action: {
                    if (isCreatedTask) {
                        updateTask(task: self.task!)
                    }
                    else {
                        createNewTask()
                    }
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "pencil")
                            .font(.title)
                        Text("Save")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                }
            }
        }
    }
    
    func fillTaskFields(newTask: Task) -> Task {
        newTask.name = self.nameText
        newTask.notes = self.descriptionText
        newTask.priority = self.priorityIndex
        newTask.status = .opened
        newTask.isDeadline = self.isDeadline
        if(isDeadline) {
            newTask.deadline = self.deadLineDate as NSDate
        }
        else {
            newTask.dateTo = self.dateTo as NSDate
            newTask.dateFrom = self.dateFrom as NSDate
        }
        return newTask
    }
    
    func incrementID() -> Int {
        return (realm.objects(Task.self).max(ofProperty: "taskId") as Int? ?? 0) + 1
    }
    
    func createNewTask() {
        var newTask = Task()
        newTask.taskId = incrementID()
        newTask = fillTaskFields(newTask: newTask)
        try! realm.write {
            realm.add(newTask)
        }
    }
    
    func updateTask(task: Task) {
        try! realm.write {
            let updatedTask = fillTaskFields(newTask: task)
            realm.add(updatedTask, update: .modified)
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
