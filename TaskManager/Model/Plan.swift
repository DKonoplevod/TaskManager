//
//  Plan.swift
//  TaskManager
//
//  Created by Данил ОТК on 26.06.2021.
//

import RealmSwift

class Plan: Object {
    @objc dynamic var planId : Int = 0
    @objc dynamic var date = NSDate()
    let planTasks = List<PlanTask>()
    
    override static func primaryKey() -> String? {
        return "planId"
    }
}
