//
//  TaskEditorInteractor.swift
//  ToDoViperCoreData
//
//  Created by Константин Натаров on 29.08.2024.
//

import Foundation


protocol ITaskEditorInteractor {
	func saveTask(task: TaskToDo, title: String, description: String, isCompleted: Bool)
}

final class TaskEditorInteractor: ITaskEditorInteractor {

	weak var presenter: ITaskEditorPresenter?
	private let coreDataManager: ICoreDataManager

	init(coreDataManager: ICoreDataManager) {
		self.coreDataManager = coreDataManager
	}

	func saveTask(task: TaskToDo, title: String, description: String, isCompleted: Bool) {
		DispatchQueue.global(qos: .background).async { [weak self] in
			guard let self = self else { return }
			task.title = title
			task.details = description
			task.isCompleted = isCompleted

			self.coreDataManager.saveContext()

			DispatchQueue.main.async {
				self.presenter?.taskDidSaveSuccessfully()
			}
		}
	}
}
