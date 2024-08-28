//
//  CoreDataManager.swift
//  ToDoViperCoreData
//
//  Created by Константин Натаров on 28.08.2024.
//

import CoreData
import UIKit

@objc(ToDoTask)
public class ToDoTask: NSManagedObject {}

protocol ICoreDataManager {
	func createTask(title: String, details: String, isCompleted: Bool) -> TaskToDo?
	func fetchAllTasks() -> [TaskToDo]
	func deleteTask(_ task: TaskToDo)
	func updateTask(_ task: TaskToDo, title: String, details: String, isCompleted: Bool)
	func fetchTask(byId id: String) -> TaskToDo?
}

final class CoreDataManager: ICoreDataManager {

	private var persistentContainer: NSPersistentContainer {
		var container: NSPersistentContainer!
		DispatchQueue.main.sync {
			guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
				fatalError("Could not retrieve persistent container from AppDelegate")
			}
			container = appDelegate.persistentContainer
		}
		return container
	}

	private var managedContext: NSManagedObjectContext {
		return persistentContainer.viewContext
	}

	// MARK: - CRUD операции
	func createTask(title: String, details: String, isCompleted: Bool) -> TaskToDo? {
		let entity = NSEntityDescription.entity(forEntityName: "TaskToDo", in: managedContext)!
		let task = NSManagedObject(entity: entity, insertInto: managedContext) as! TaskToDo

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

	// Получение всех задач
	func fetchAllTasks() -> [TaskToDo] {
		let fetchRequest = NSFetchRequest<TaskToDo>(entityName: "TaskToDo")

		do {
			let tasks = try managedContext.fetch(fetchRequest)
			return tasks
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
			return []
		}
	}

	// Удаление задачи
	func deleteTask(_ task: TaskToDo) {
		managedContext.delete(task)

		do {
			try managedContext.save()
		} catch let error as NSError {
			print("Could not delete. \(error), \(error.userInfo)")
		}
	}

	// Обновление задачи
	func updateTask(_ task: TaskToDo, title: String, details: String, isCompleted: Bool) {
		task.title = title
		task.details = details
		task.isCompleted = isCompleted

		do {
			try managedContext.save()
		} catch let error as NSError {
			print("Could not update. \(error), \(error.userInfo)")
		}
	}

	// Получение задачи по ID
	func fetchTask(byId id: String) -> TaskToDo? {
		let fetchRequest = NSFetchRequest<TaskToDo>(entityName: "TaskToDo")
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
