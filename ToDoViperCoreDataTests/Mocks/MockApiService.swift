//
//  MockApiService.swift
//  ToDoViperCoreDataTests
//
//  Created by Константин Натаров on 29.08.2024.
//

import Foundation
@testable import ToDoViperCoreData

final class MockApiService: IAPIService {
	var fetchTasksCalled = false

	func fetchTasks(completion: @escaping (Result<[TaskDTO], Error>) -> Void) {
		fetchTasksCalled = true
		let mockTasks = [TaskDTO(id: 1, todo: "Mock Task", completed: false)]
		completion(.success(mockTasks))
	}
}
