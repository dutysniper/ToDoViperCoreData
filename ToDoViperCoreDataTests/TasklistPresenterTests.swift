//
//  ToDoViperCoreDataTests.swift
//  ToDoViperCoreDataTests
//
//  Created by Константин Натаров on 26.08.2024.
//

import XCTest
@testable import ToDoViperCoreData

final class TasklistPresenterTests: XCTestCase {
	var sut: TasklistPresenter!
	var mockViewController: MockTasklistViewController!
	var mockInteractor: MockTasklistInteractor!
	var router: MockRouter!

	override func setUp() {
		super.setUp()
		mockViewController = MockTasklistViewController()
		mockInteractor = MockTasklistInteractor()
		router = MockRouter()
		sut = TasklistPresenter()

		sut.interactor = mockInteractor
		sut.view = mockViewController
		sut.router = router
	}

	func testFetchTasks() {
		sut.fetchTasks()
		XCTAssertTrue(mockInteractor.fetchTasksCalled, "fetchTasks() должен вызывать метод интерактора fetchTasks")
	}

	func testAddTask() {
		sut.didAddTask(title: "Test Task", description: "Test Description")
		XCTAssertTrue(mockInteractor.addTaskCalled, "didAddTask() должен вызывать метод интерактора addTask")
	}

	func testSelectTask() {
		let task = TaskToDo()
		sut.didSelectTask(task)
		XCTAssertTrue(router.navigateToTaskDetailCalled, "didSelectTask() должен вызвать метод роутера navigateToTaskDetail")
	}

	func test_deleteTask_shouldBeTrue() {
		let task = TaskToDo()
		sut.didDeleteTask(task)
		XCTAssertTrue(mockInteractor.deleteTaskCalled, "Ожидалось True")
	}
}
