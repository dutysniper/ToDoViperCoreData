//
//  MockCoreDataManager.swift
//  ToDoViperCoreDataTests
//
//  Created by Константин Натаров on 29.08.2024.
//

import Foundation
@testable import ToDoViperCoreData

final class MockCoreDataManager: ICoreDataManager {
	var createTaskCalled = false
	var fetchAllTasksCalled = false
	var deleteTaskCalled = false
	var updateTaskCalled = false
	var fetchTaskByIdCalled = false
	var saveContextCalled = false

	var tasks: [TaskToDo] = []

	func createTask(title: String, details: String, isCompleted: Bool) -> TaskToDo? {
		createTaskCalled = true
		let task = TaskToDo()
		task.id = UUID().uuidString
		task.title = title
		task.details = details
		task.isCompleted = isCompleted
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
		task.title = title
		task.details = details
		task.isCompleted = isCompleted
	}

	func fetchTask(byId id: String) -> TaskToDo? {
		fetchTaskByIdCalled = true
		return tasks.first { $0.id == id }
	}

	func saveContext() {
		saveContextCalled = true
	}
}
