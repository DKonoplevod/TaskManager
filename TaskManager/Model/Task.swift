//
//  Task.swift
//  TaskManager
//
//  Created by Данил ОТК on 25.06.2021.
//

import RealmSwift

@objc enum TaskStatus : Int, RealmEnum {
    case opened
    case inWork
    case done
}


@objc enum Priority : Int, RealmEnum {
    case none
    case low
    case medium
    case high
}

class Task: Object {
    @objc dynamic var taskId : Int = 0
    @objc dynamic var name : String = ""
    @objc dynamic var notes : String = ""
    @objc dynamic var status : TaskStatus = .opened
    @objc dynamic var priority : Priority = .none
    @objc dynamic var deadline : NSDate = NSDate()
    @objc dynamic var isDeadline = false
    @objc dynamic var dateTo : NSDate = NSDate()
    @objc dynamic var dateFrom : NSDate = NSDate()
    
    override static func primaryKey() -> String? {
        return "taskId"
    }
}
