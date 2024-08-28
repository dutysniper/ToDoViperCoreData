//
//  CoreDataManager.swift
//  ToDoViperCoreData
//
//  Created by Константин Натаров on 28.08.2024.
//

import UIKit
import CoreData

protocol ICoreDataManager {
	func createTask(title: String, details: String, isCompleted: Bool) -> ToDoTask?
	func fetchAllTasks() -> [ToDoTask]
	func deleteTask(_ task: ToDoTask)
	func updateTask(_ task: ToDoTask, title: String, details: String, isCompleted: Bool)
	func fetchTask(byId id: String) -> ToDoTask?
}

final class CoreDataManager: ICoreDataManager {

	private var persistentContainer: NSPersistentContainer {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			fatalError("Could not retrieve persistent container from AppDelegate")
		}
		return appDelegate.persistentContainer
	}

	private var managedContext: NSManagedObjectContext {
		return persistentContainer.viewContext
	}

	// MARK: - CRUD операции
	func createTask(title: String, details: String, isCompleted: Bool) -> ToDoTask? {
		let entity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)!
		let task = ToDoTask(entity: entity, insertInto: managedContext)

		// Генерация уникального идентификатора для новой задачи
		task.id = UUID().uuidString
		task.title = title
		task.details = details
		task.isCompleted = isCompleted
		task.createdAt = Date()

		do {
			try managedContext.save()
			return task
		} catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
			return nil
		}
	}

	func fetchAllTasks() -> [ToDoTask] {
		let fetchRequest: NSFetchRequest<ToDoTask> = ToDoTask.fetchRequest()

		do {
			let tasks = try managedContext.fetch(fetchRequest)
			return tasks
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
			return []
		}
	}

	func deleteTask(_ task: ToDoTask) {
		managedContext.delete(task)

		do {
			try managedContext.save()
		} catch let error as NSError {
			print("Could not delete. \(error), \(error.userInfo)")
		}
	}

	func updateTask(_ task: ToDoTask, title: String, details: String, isCompleted: Bool) {
		task.title = title
		task.details = details
		task.isCompleted = isCompleted

		do {
			try managedContext.save()
		} catch let error as NSError {
			print("Could not update. \(error), \(error.userInfo)")
		}
	}

	func fetchTask(byId id: String) -> ToDoTask? {
		let fetchRequest: NSFetchRequest<ToDoTask> = ToDoTask.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "id == %@", id)

		do {
			let tasks = try managedContext.fetch(fetchRequest)
			return tasks.first
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
			return nil
		}
	}
}
