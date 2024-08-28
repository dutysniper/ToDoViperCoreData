//
//  TasklistRouter.swift
//  ToDoViperCoreData
//
//  Created by Константин Натаров on 26.08.2024.
//

import Foundation

protocol ITasklistRouter {
	func navigateToTaskDetail(_ task: TaskToDo)
}

final class TasklistRouter: ITasklistRouter {

	func navigateToTaskDetail(_ task: TaskToDo) {
//		let taskDetailViewController = TaskDetailRouter.createTaskDetailModule(with: task)
//		if let sourceView = (presenter as? TaskListPresenter)?.view as? UIViewController {
//			sourceView.navigationController?.pushViewController(taskDetailViewController, animated: true)
	}
}
