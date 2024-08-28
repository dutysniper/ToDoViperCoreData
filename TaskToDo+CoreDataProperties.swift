//
//  TaskToDo+CoreDataProperties.swift
//  ToDoViperCoreData
//
//  Created by Константин Натаров on 28.08.2024.
//
//

import UIKit
import CoreData

extension TaskToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskToDo> {
        return NSFetchRequest<TaskToDo>(entityName: "TaskToDo")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var details: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var createdAt: Date?

}

extension TaskToDo : Identifiable {

}
