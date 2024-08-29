//
//  MockTaskEditorInteractor.swift
//  ToDoViperCoreDataTests
//
//  Created by Константин Натаров on 29.08.2024.
//

import Foundation
@testable import ToDoViperCoreData

final class MockTaskEditorInteractor: ITaskEditorInteractor {
	var saveTaskCalled = false

	func saveTask(task: TaskToDo, title: String, description: String, isCompleted: Bool) {
		saveTaskCalled = true
	}
}
