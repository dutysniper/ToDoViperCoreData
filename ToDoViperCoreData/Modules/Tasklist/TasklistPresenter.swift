//
//  TasklistPresenter.swift
//  ToDoViperCoreData
//
//  Created by Константин Натаров on 26.08.2024.
//

import Foundation

protocol ITasklistPresenter {
	func presentTasks(_ tasks: [Task])
	func didAddTask(_ task: Task)
	func didUpdateTask(_ task: Task)
	func didDeleteTask(_ task: Task)
}

final class TasklistPresenter: ITasklistPresenter {

	var view: ITasklistViewController?

	func presentTasks(_ tasks: [Task]) {

	}

	func didAddTask(_ task: Task) {

	}

	func didUpdateTask(_ task: Task) {

	}

	func didDeleteTask(_ task: Task) {
		
	}


}
