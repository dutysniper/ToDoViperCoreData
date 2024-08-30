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

	var displayedTasks: [MockTaskToDo] = []

	func fetchTasks() {
		fetchTasksCalled = true
	}

	func displayTasks(tasks: [TaskToDo]) {
		displayTasksCalled = true
		displayedTasks = tasks.map { $0 as! MockTaskToDo }
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
