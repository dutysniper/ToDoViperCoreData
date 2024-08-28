//
//  ToDoTask+CoreDataProperties.swift
//  ToDoViperCoreData
//
//  Created by Константин Натаров on 28.08.2024.
//
//

import Foundation
import CoreData


extension ToDoTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoTask> {
        return NSFetchRequest<ToDoTask>(entityName: "ToDoTask")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var details: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var createdAt: Date?

}

extension ToDoTask : Identifiable {

}
