//
//  TaskEditorPresenter.swift
//  ToDoViperCoreData
//
//  Created by Константин Натаров on 29.08.2024.
//

import Foundation

/// Интерфейс для взаимодействия с презентором
protocol ITaskEditorPresenter: AnyObject {
	func loadTaskDetails()
	func didTapSaveButton(title: String, description: String, isCompleted: Bool)
	func taskDidSaveSuccessfully()
}

final class TaskEditorPresenter: ITaskEditorPresenter {

	// MARK: - Dependencies

	weak var view: ITaskEditorViewController?
	private let interactor: ITaskEditorInteractor

	// MARK: - Private properties
	
	/// Задача, на которую нажал пользователь на экране Tasklist
	private let task: TaskToDo

	// MARK: - Initialization

	init(view: ITaskEditorViewController, interactor: ITaskEditorInteractor, task: TaskToDo) {
		self.view = view
		self.interactor = interactor
		self.task = task
	}

	// MARK: - Public methods

	/// Метод для загрузки данных задачи для отображения в VC
	func loadTaskDetails() {
		view?.displayTaskDetails(task: task)
	}

	/// Метод для вызова метода интерактора по сохранению задачи
	func didTapSaveButton(title: String, description: String, isCompleted: Bool) {
		interactor.saveTask(task: task, title: title, description: description, isCompleted: isCompleted)
	}

	/// Метод для вызова метода VC для уведомления об успехе сохранения
	func taskDidSaveSuccessfully() {
		view?.showSaveSuccess()
	}
}
