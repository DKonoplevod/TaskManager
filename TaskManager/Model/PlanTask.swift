//
//  PlanTask.swift
//  TaskManager
//
//  Created by Данил ОТК on 26.06.2021.
//

import RealmSwift

class PlanTask: Object {
    @objc dynamic var planTaskId : Int = 0
    @objc dynamic var startTime : NSDate = NSDate()
    @objc dynamic var endTime : NSDate = NSDate()
    let task : Task? = nil

    override static func primaryKey() -> String? {
        return "planTaskId"
    }
}
