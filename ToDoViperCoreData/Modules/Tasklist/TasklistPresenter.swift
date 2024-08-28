//
//  TasklistPresenter.swift
//  ToDoViperCoreData
//
//  Created by Константин Натаров on 26.08.2024.
//

import Foundation

protocol ITasklistPresenter: AnyObject {
	func fetchTasks()
	func displayTasks(tasks: [TaskToDo])
	func didSelectTask(_ task: TaskToDo)
	func didDeleteTask(_ task: TaskToDo)
	func didAddTask(title: String, description: String)
}

final class TasklistPresenter: ITasklistPresenter {

	weak var view: ITasklistViewController?
	var interactor: ITasklistInteractor?
	var router: ITasklistRouter?

	func displayTasks(tasks: [TaskToDo]) {
		view?.displayTasks(tasks)
	}

	func fetchTasks() {
		interactor?.fetchTasks()
	}

	func didSelectTask(_ task: TaskToDo) {
		router?.navigateToTaskDetail(task)
	}

	// Метод для удаления задачи
	func didDeleteTask(_ task: TaskToDo) {
		interactor?.deleteTask(task)
	}

	func didAddTask(title: String, description: String) {
		interactor?.addTask(title: title, description: description)
	}
}
