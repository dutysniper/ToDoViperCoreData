//
//  APIService.swift
//  ToDoViperCoreData
//
//  Created by Константин Натаров on 28.08.2024.
//

import Foundation

protocol IAPIService {
	func fetchTasks(completion: @escaping (Result<[TaskDTO], Error>) -> Void)
}

final class APIService: IAPIService {
	func fetchTasks(completion: @escaping (Result<[TaskDTO], Error>) -> Void) {
		let url = URL(string: "https://dummyjson.com/todos")!

		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				completion(.failure(error))
				return
			}

			guard let data = data else {
				let error = NSError(domain: "com.example.app", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])
				completion(.failure(error))
				return
			}

			do {
				let decoder = JSONDecoder()
				let taskListResponse = try decoder.decode(TaskListResponse.self, from: data)
				let tasks = taskListResponse.todos
				completion(.success(tasks))
			} catch {
				completion(.failure(error))
			}
		}
		task.resume()
	}
}


// Модель для задачи из API
struct TaskDTO: Decodable {
	let id: Int
	let todo: String  // соответствие с полем "todo" в JSON
	let completed: Bool

	enum CodingKeys: String, CodingKey {
		case id
		case todo
		case completed
	}
}

// Модель для корневого JSON объекта
struct TaskListResponse: Decodable {
	let todos: [TaskDTO]
	let total: Int
	let skip: Int
	let limit: Int
}
