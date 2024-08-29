//
//  MockTaskEditorViewController.swift
//  ToDoViperCoreDataTests
//
//  Created by Константин Натаров on 29.08.2024.
//

import Foundation
@testable import ToDoViperCoreData

final class MockTaskEditorViewController: ITaskEditorViewController {
	var displayTaskDetailsCalled = false
	var showSaveSuccessCalled = false

	func displayTaskDetails(task: TaskToDo) {
		displayTaskDetailsCalled = true
	}

	func showSaveSuccess() {
		showSaveSuccessCalled = true
	}
}
