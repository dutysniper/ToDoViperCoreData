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
		let viewController = TasklistViewController()
		let presenter = TasklistPresenter()
		let interactor = TasklistInteractor()
		let router = TasklistRouter()

		viewController.presenter = presenter
		presenter.view = viewController
		presenter.interactor = interactor
		presenter.router = router
		interactor.presenter = presenter

		return viewController
	}
}
