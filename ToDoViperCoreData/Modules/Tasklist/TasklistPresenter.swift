//
//  TasklistPresenter.swift
//  ToDoViperCoreData
//
//  Created by Константин Натаров on 26.08.2024.
//

import Foundation

/// Интьерфейс для взаимодействия с презентером
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
	var router: IRouter?

	/// Метод для отображения тасок
	func displayTasks(tasks: [TaskToDo]) {
		view?.displayTasks(tasks)
	}

	/// Загрузка тасок
	func fetchTasks() {
		interactor?.fetchTasks()
	}

	/// Выбор такси пользователем
	func didSelectTask(_ task: TaskToDo) {
		router?.navigateToTaskDetail(task)
	}

	/// Метод для удаления задачи
	func didDeleteTask(_ task: TaskToDo) {
		interactor?.deleteTask(task)
	}

	func didAddTask(title: String, description: String) {
		interactor?.addTask(title: title, description: description)
	}
}
