//
//  TasklistRouter.swift
//  ToDoViperCoreData
//
//  Created by Константин Натаров on 26.08.2024.
//

import Foundation

/// Интерфейс для взаимодействия с роутером
protocol IRouter {
	func navigateToTaskDetail(_ task: TaskToDo)
}

/// Роутер для навигации
final class Router: IRouter {
	weak var tasklistVC: TasklistViewController?

	func navigateToTaskDetail(_ task: TaskToDo) {
		let taskEditorVC = TaskEditorAssembler.assembleModule(task: task)
		tasklistVC?.navigationController?.pushViewController(taskEditorVC, animated: true)
	}
}
