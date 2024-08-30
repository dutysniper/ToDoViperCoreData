//
//  MockCoreDataManager.swift
//  ToDoViperCoreDataTests
//
//  Created by Константин Натаров on 29.08.2024.
//

import Foundation
import CoreData
@testable import ToDoViperCoreData

final class MockCoreDataManager: ICoreDataManager {
	var createTaskCalled = false
	var fetchAllTasksCalled = false
	var deleteTaskCalled = false
	var updateTaskCalled = false
	var fetchTaskByIdCalled = false
	var saveContextCalled = false

	var tasks: [MockTaskToDo] = []

	func createTask(title: String, details: String, isCompleted: Bool) -> TaskToDo? {
		createTaskCalled = true
		let task = MockTaskToDo(title: title, details: details, isCompleted: isCompleted)
		tasks.append(task)
		
		return task
	}

	func fetchAllTasks() -> [TaskToDo] {
		fetchAllTasksCalled = true
		return tasks
	}

	func deleteTask(_ task: TaskToDo) {
		deleteTaskCalled = true
		if let index = tasks.firstIndex(where: { $0.id == task.id }) {
			tasks.remove(at: index)
		}
	}

	func updateTask(_ task: TaskToDo, title: String, details: String, isCompleted: Bool) {
		updateTaskCalled = true
		if let mockTask = task as? MockTaskToDo {
			mockTask.title = title
			mockTask.details = details
			mockTask.isCompleted = isCompleted
		}
	}

	func fetchTask(byId id: String) -> TaskToDo? {
		fetchTaskByIdCalled = true
		return tasks.first { $0.id == id }
	}

	func saveContext() {
		saveContextCalled = true
	}
}

final class MockTaskToDo: TaskToDo {

	private var mockId: String?
	private var mockTitle: String?
	private var mockDetails: String?
	private var mockIsCompleted: Bool = false

	override var id: String? {
		get { return mockId }
		set { mockId = newValue }
	}

	override var title: String? {
		get { return mockTitle }
		set { mockTitle = newValue }
	}

	override var details: String? {
		get { return mockDetails }
		set { mockDetails = newValue }
	}

	override var isCompleted: Bool {
		get { return mockIsCompleted }
		set { mockIsCompleted = newValue }
	}

	// Фабричный метод для создания экземпляра MockTaskToDo
	static func createMockTask(id: String? = nil, title: String? = nil, details: String? = nil, isCompleted: Bool = false, context: NSManagedObjectContext) -> MockTaskToDo {
		let task = NSEntityDescription.insertNewObject(forEntityName: "TaskToDo", into: context) as! MockTaskToDo
		task.mockId = id
		task.mockTitle = title
		task.mockDetails = details
		task.mockIsCompleted = isCompleted
		return task
	}
}
