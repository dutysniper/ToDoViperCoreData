//
//  TasklistInteractor.swift
//  ToDoViperCoreData
//
//  Created by Константин Натаров on 26.08.2024.
//

import Foundation

protocol ITasklistInteractor {
	func fetchTasks()
	func addTask(_ task: Task)
	func updateTask(_task: Task)
	func deleteTask(_task: Task)
}

final class TasklistInteractor: ITasklistInteractor {
	var presenter: ITasklistPresenter?
	func fetchTasks() {

	}

	func addTask(_ task: Task) {

	}

	func updateTask(_task: Task) {

	}

	func deleteTask(_task: Task) {
		
	}
}
