//
//  MockRouter.swift
//  ToDoViperCoreDataTests
//
//  Created by Константин Натаров on 29.08.2024.
//

import Foundation
@testable import ToDoViperCoreData

final class MockRouter: IRouter {
	var navigateToTaskDetailCalled = false
	var navigateToTaskDetailTask: TaskToDo?

	func navigateToTaskDetail(_ task: TaskToDo) {
		navigateToTaskDetailCalled = true
		navigateToTaskDetailTask = task
	}
}
