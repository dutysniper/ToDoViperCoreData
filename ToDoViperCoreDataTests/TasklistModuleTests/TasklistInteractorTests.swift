//
//  TasklistInteractorTests.swift
//  ToDoViperCoreDataTests
//
//  Created by Константин Натаров on 29.08.2024.
//

import XCTest
@testable import ToDoViperCoreData

final class TasklistInteractorTests: XCTestCase {
	var interactor: TasklistInteractor!
	var mockCoreDataManager: MockCoreDataManager!
	var mockApiService: MockApiService!
	var mockPresenter: MockTasklistPresenter!

	override func setUp() {
		super.setUp()
		mockCoreDataManager = MockCoreDataManager()
		mockApiService = MockApiService()
		mockPresenter = MockTasklistPresenter()
		interactor = TasklistInteractor(coreDataManager: mockCoreDataManager, apiService: mockApiService)
		interactor.presenter = mockPresenter

		UserDefaults.standard.removeObject(forKey: "isFirstLaunch")
	}

	func testFetchTasksFirstLaunch() {

		UserDefaults.standard.set(false, forKey: "isFirstLaunch")

		// Ожидаем выполнение асинхронного кода
		let expectation = self.expectation(description: "fetchTasks completion")

		// Запускаем fetchTasks
		interactor.fetchTasks()

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			XCTAssertTrue(self.mockApiService.fetchTasksCalled, "fetchTasks() должен вызывать метод apiService fetchTasks")
			XCTAssertTrue(self.mockCoreDataManager.createTaskCalled, "fetchTasks() должен вызывать метод coreDataManager createTask")
			XCTAssertTrue(self.mockCoreDataManager.fetchAllTasksCalled, "fetchTasks() должен вызывать метод coreDataManager fetchAllTasks")
			XCTAssertTrue(self.mockPresenter.displayTasksCalled, "fetchTasks() должен вызывать метод presenter displayTasks")
			expectation.fulfill()
		}

		waitForExpectations(timeout: 2, handler: nil)
	}

	func testFetchTasksSubsequentLaunch() {

		UserDefaults.standard.set(true, forKey: "isFirstLaunch")


		let expectation = self.expectation(description: "fetchTasks completion")


		interactor.fetchTasks()

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			XCTAssertFalse(self.mockApiService.fetchTasksCalled, "fetchTasks() не должен вызывать метод apiService fetchTasks на последующих запусках")
			XCTAssertTrue(self.mockCoreDataManager.fetchAllTasksCalled, "fetchTasks() должен вызывать метод coreDataManager fetchAllTasks")
			XCTAssertTrue(self.mockPresenter.displayTasksCalled, "fetchTasks() должен вызывать метод presenter displayTasks")
			expectation.fulfill()
		}


		waitForExpectations(timeout: 2, handler: nil)
	}

	func testAddTask() {

		let expectation = self.expectation(description: "addTask completion")

		interactor.addTask(title: "New Task", description: "New Description")

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			XCTAssertTrue(self.mockCoreDataManager.createTaskCalled, "addTask() должен вызывать метод coreDataManager createTask")
			XCTAssertTrue(self.mockPresenter.displayTasksCalled, "addTask() должен вызывать метод presenter displayTasks")
			expectation.fulfill()
		}

		waitForExpectations(timeout: 2, handler: nil)
	}

	func testDeleteTask() {
		let task = TaskToDo()
		task.id = "1"
		mockCoreDataManager.tasks = [task]

		let expectation = self.expectation(description: "deleteTask completion")

		interactor.deleteTask(task)

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			XCTAssertTrue(self.mockCoreDataManager.deleteTaskCalled, "deleteTask() должен вызывать метод coreDataManager deleteTask")
			XCTAssertTrue(self.mockPresenter.displayTasksCalled, "deleteTask() должен вызывать метод presenter displayTasks")
			expectation.fulfill()
		}

		waitForExpectations(timeout: 2, handler: nil)
	}
}
