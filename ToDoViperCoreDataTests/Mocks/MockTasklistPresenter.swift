//
//  MockTasklistPresenter.swift
//  ToDoViperCoreDataTests
//
//  Created by Константин Натаров on 29.08.2024.
//
import Foundation
@testable import ToDoViperCoreData

final class MockTasklistPresenter: ITasklistPresenter {
	var fetchTasksCalled = false
	var displayTasksCalled = false
	var didSelectTaskCalled = false
	var didDeleteTaskCalled = false
	var didAddTaskCalled = false

	var displayedTasks: [TaskToDo] = []

	func fetchTasks() {
		fetchTasksCalled = true
	}

	func displayTasks(tasks: [TaskToDo]) {
		displayTasksCalled = true
		displayedTasks = tasks
	}

	func didSelectTask(_ task: TaskToDo) {
		didSelectTaskCalled = true
	}

	func didDeleteTask(_ task: TaskToDo) {
		didDeleteTaskCalled = true
	}

	func didAddTask(title: String, description: String) {
		didAddTaskCalled = true
	}
}
