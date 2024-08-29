//
//  MockTasklistViewController.swift
//  ToDoViperCoreDataTests
//
//  Created by Константин Натаров on 29.08.2024.
//

import UIKit
@testable import ToDoViperCoreData

final class MockTasklistViewController: ITasklistViewController {
	var displayTasksCalled = false
	var addTaskToViewCalled = false
	var updateTaskInViewCalled = false
	var removeTaskFromViewCalled = false

	func displayTasks(_ tasks: [TaskToDo]) {
		displayTasksCalled = true
	}

	func addTaskToView(_ task: TaskToDo) {
		addTaskToViewCalled = true
	}

	func updateTaskInView(_ task: TaskToDo) {
		updateTaskInViewCalled = true
	}

	func removeTaskFromView(_ task: TaskToDo) {
		removeTaskFromViewCalled = true
	}
}
