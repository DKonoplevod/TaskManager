//
//  BacklogView.swift
//  TaskManager
//
//  Created by Данил ОТК on 27.06.2021.
//

import SwiftUI

struct BacklogView: View {
    
    @State var tasks = realm.objects(Task.self).sorted(byKeyPath: "priority", ascending: false)
    @State private var goToAddTaskPage = false

    var body: some View {
        VStack {
            List {
                ForEach(self.tasks, id: \.self) { task in
                    NavigationLink(destination: AddTaskView(task: task)) {
                        HStack {
                            VStack (alignment: .leading) {
                                Text(task.name)
                                    .font(.headline)
                                    .foregroundColor(task.priority == .high ?
                                                        .red :
                                                            task.priority == .medium ?
                                                            .yellow :
                                                                task.priority == .low ?
                                                                .blue :
                                                        .black)
                                Text(getDateString(task: task))
                                    .font(.subheadline)
                                    .foregroundColor(getDateColor(task: task))
                            }
                            .padding()
                            Spacer()
                        }
                    }
                }
                .onDelete(perform: self.deleteItem)
            }.navigationBarTitle("Backlog")
        }
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            )
        .onAppear(perform: {reload()})
    }
    
    func getDateColor(task: Task) -> Color {
        let now = Date()
        let delta : Double
        if (task.isDeadline) {
            delta = (task.deadline as Date).timeIntervalSince(now)
        }
        else {
            delta = (task.dateFrom as Date).timeIntervalSince(now)
        }
        return getColorByDateDelta(delta: delta)
    }
    
    func getColorByDateDelta(delta : Double) -> Color {
        if (delta < 0) {
            return .red
        }
        else if (delta < 24*60*60) {
            return .yellow
        }
        else
        {
            return .gray
        }
    }
    
    func getDateString(task : Task) -> String {
        if (!task.isDeadline) {
            return "\(dateToString(date: task.dateFrom as Date)) - \(dateToString(date: task.dateTo as Date))"
        }
        else {
            return dateToString(date: task.deadline as Date)
        }
    }
    
    func dateToString(date : Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy hh:mm"
        return df.string(from: date)
    }
    
    func reload() {
        tasks = realm.objects(Task.self).sorted(byKeyPath: "priority",  ascending: false)
    }
    
    func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            let task = tasks[index]
            try! realm.write {
                realm.delete(task)
            }
        }
    }
}

struct BacklogView_Previews: PreviewProvider {
    static var previews: some View {
        BacklogView()
    }
}
