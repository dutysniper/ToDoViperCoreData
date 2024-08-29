//
//  MockTasklistInteracor.swift
//  ToDoViperCoreDataTests
//
//  Created by Константин Натаров on 29.08.2024.
//

import Foundation
@testable import ToDoViperCoreData

final class MockTasklistInteractor: ITasklistInteractor {
	var fetchTasksCalled = false
	var deleteTaskCalled = false
	var addTaskCalled = false
	var updateTaskStatusCalled = false

	func fetchTasks() {
		fetchTasksCalled = true
	}

	func deleteTask(_ task: TaskToDo) {
		deleteTaskCalled = true
	}

	func addTask(title: String, description: String) {
		addTaskCalled = true
	}

	func updateTaskStatus(_ task: TaskToDo, isCompleted: Bool) {
		updateTaskStatusCalled = true
	}
}
