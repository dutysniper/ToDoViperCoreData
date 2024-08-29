//
//  TasklistAssembler.swift
//  ToDoViperCoreData
//
//  Created by Константин Натаров on 28.08.2024.
//

import UIKit

protocol ITasklistAssembler {
	static func assembleModule() -> UIViewController
}

final class TasklistAssembler: ITasklistAssembler {

	static func assembleModule() -> UIViewController {
		let coreDataManager = CoreDataManager()
		let apiService = APIService()
		let viewController = TasklistViewController()
		let presenter = TasklistPresenter()
		let interactor = TasklistInteractor(coreDataManager: coreDataManager, apiService: apiService)
		let router = Router()

		viewController.presenter = presenter
		presenter.view = viewController
		presenter.interactor = interactor
		presenter.router = router
		interactor.presenter = presenter
		router.tasklistVC = viewController

		return viewController
	}
}
