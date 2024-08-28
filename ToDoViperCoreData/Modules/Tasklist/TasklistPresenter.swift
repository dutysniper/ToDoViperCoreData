//
//  TasklistPresenter.swift
//  ToDoViperCoreData
//
//  Created by Константин Натаров on 26.08.2024.
//

import Foundation

protocol ITasklistPresenter: AnyObject {
	func fetchTasks()
	func displayTasks(_ tasks: [TaskToDo])
	func didSelectTask(_ task: TaskToDo)
	func didDeleteTask(_ task: TaskToDo)
	func didAddTask(title: String, description: String)
}

final class TasklistPresenter: ITasklistPresenter {

	weak var view: ITasklistViewController?  // Ссылка на View (UI)
	var interactor: ITasklistInteractor?  // Ссылка на Interactor (бизнес-логика)
	var router: ITasklistRouter?  // Ссылка на Router (навигация)

	func displayTasks(_ tasks: [TaskToDo]) {
		view?.displayTasks(tasks)
	}
	// Метод для загрузки задач
	func fetchTasks() {
		interactor?.fetchTasks()  // Запрашиваем у Interactor загрузить задачи
	}

	// Метод, который вызывается при выборе задачи
	func didSelectTask(_ task: TaskToDo) {
		router?.navigateToTaskDetail(task)  // Осуществляем навигацию к экрану детализации задачи
	}

	// Метод для удаления задачи
	func didDeleteTask(_ task: TaskToDo) {
		interactor?.deleteTask(task)  // Удаляем задачу через Interactor
	}

	// Метод для добавления новой задачи
	func didAddTask(title: String, description: String) {
		interactor?.addTask(title: title, description: description)  // Создаем новую задачу через Interactor
	}
}
