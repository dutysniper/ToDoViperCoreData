//
//  TaskEditorAssembler.swift
//  ToDoViperCoreData
//
//  Created by Константин Натаров on 29.08.2024.
//

import UIKit

protocol ITaskEditorAssembler {
	static func assembleModule(task: TaskToDo) -> UIViewController
}

final class TaskEditorAssembler: ITaskEditorAssembler {
	static func assembleModule(task: TaskToDo) -> UIViewController {

		let coreDataManager = CoreDataManager()

		let interactor = TaskEditorInteractor(coreDataManager: coreDataManager)

		let viewController = TaskEditorViewController()

		let presenter = TaskEditorPresenter(view: viewController, interactor: interactor, task: task)

		viewController.presenter = presenter
		interactor.presenter = presenter
		return viewController

	}
}
