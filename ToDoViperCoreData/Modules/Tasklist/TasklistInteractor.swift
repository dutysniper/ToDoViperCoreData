//
//  TasklistInteractor.swift
//  ToDoViperCoreData
//
//  Created by Константин Натаров on 26.08.2024.
//

import Foundation

protocol ITasklistInteractor: AnyObject {
	func fetchTasks()
	func deleteTask(_ task: Task)
	func addTask(title: String, description: String)
}

final class TasklistInteractor: ITasklistInteractor {
	weak var presenter: ITasklistPresenter?

	func fetchTasks() {
		DispatchQueue.global(qos: .background).async { [weak self] in
			let tasks = CoreDataManager.shared.fetchAllTasks()

			DispatchQueue.main.async {
				self?.presenter?.view?.displayTasks(tasks)
			}
		}
	}

	func deleteTask(_ task: Task) {
		DispatchQueue.global(qos: .background).async { [weak self] in
			CoreDataManager.shared.deleteTask(task)

			DispatchQueue.main.async {
				self?.fetchTasks()
			}
		}
	}

	func addTask(title: String, description: String) {
		DispatchQueue.global(qos: .background).async { [weak self] in
			let newTask = CoreDataManager.shared.createTask(
				title: title,
				details: description,
				isCompleted: false
			)

			DispatchQueue.main.async {
				self?.fetchTasks()
			}
		}
	}
}

