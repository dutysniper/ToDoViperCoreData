//
//  TasklistInteractor.swift
//  ToDoViperCoreData
//
//  Created by Константин Натаров on 26.08.2024.
//

import Foundation

protocol ITasklistInteractor: AnyObject {
	func fetchTasks()
	func deleteTask(_ task: TaskToDo)
	func addTask(title: String, description: String)
}

final class TasklistInteractor: ITasklistInteractor {
	weak var presenter: ITasklistPresenter?
	private var coreDataManager: ICoreDataManager
	private var apiService: IAPIService

	private let userDefaults = UserDefaults.standard
	private let firstLaunchKey = "isFirstLaunch"

	init(coreDataManager: ICoreDataManager, apiService: IAPIService) {
		self.coreDataManager = coreDataManager
		self.apiService = apiService
	}

	func fetchTasks() {
		let isFirstLaunch = !userDefaults.bool(forKey: firstLaunchKey)

		if isFirstLaunch {
			// Fetch tasks from API on first launch
			apiService.fetchTasks { [weak self] result in
				switch result {
				case .success(let tasksDTO):
					DispatchQueue.global(qos: .background).async {
						for taskDTO in tasksDTO {
							_ = self?.coreDataManager.createTask(
								title: taskDTO.todo,
								details: "",
								isCompleted: taskDTO.completed
							)
						}

						self?.userDefaults.set(true, forKey: self?.firstLaunchKey ?? "isFirstLaunch")
						self?.userDefaults.synchronize()

						let allTasks = self?.coreDataManager.fetchAllTasks() ?? []
						DispatchQueue.main.async {
							self?.presenter?.displayTasks(tasks: allTasks)
						}
					}

				case .failure(let error):
					print("Failed to fetch tasks from API: \(error)")
					self?.loadTasksFromCoreData()
				}
			}
		} else {
			// Fetch tasks from Core Data on subsequent launches
			loadTasksFromCoreData()
		}
	}

	private func loadTasksFromCoreData() {
		DispatchQueue.global(qos: .background).async { [weak self] in
			let allTasks = self?.coreDataManager.fetchAllTasks() ?? []
			DispatchQueue.main.async {
				self?.presenter?.displayTasks(tasks: allTasks)
			}
		}
	}

	func deleteTask(_ task: TaskToDo) {
		DispatchQueue.global(qos: .background).async { [weak self] in
			guard let self = self else { return }
			self.coreDataManager.deleteTask(task)
			DispatchQueue.main.async {
				self.loadTasksFromCoreData()
			}
		}
	}

	func addTask(title: String, description: String) {
		DispatchQueue.global(qos: .background).async { [weak self] in
			guard let self = self else { return }
			let newTask = self.coreDataManager.createTask(
				title: title,
				details: description,
				isCompleted: false
			)
			DispatchQueue.main.async {
				self.fetchTasks()
			}
		}
	}
}
