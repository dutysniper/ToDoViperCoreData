//
//  TasklistViewController.swift
//  ToDoViperCoreData
//
//  Created by Константин Натаров on 26.08.2024.
//

import UIKit

protocol ITasklistViewController: AnyObject {
	func displayTasks(_ tasks: [TaskToDo])
	func addTaskToView(_ task: TaskToDo)
	func updateTaskInView(_ task: TaskToDo)
	func removeTaskFromView(_ task: TaskToDo)
}

final class TasklistViewController: UIViewController {
	// MARK: - Public properties

	var tasks: [TaskToDo] = []

	// MARK: - Dependencies

	var presenter: ITasklistPresenter?

	// MARK: - Private properties

	private lazy var tableViewTasklist: UITableView = makeTableView()

	// MARK: - Initialization

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Life Cycle VC

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		presenter?.fetchTasks()
		print("")
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		tableViewTasklist.reloadData()

	}
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layout()
	}

	// MARK: - Private methods

	private func setupUI() {
		title = "ToDo List"
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .add,
			target: self,
			action: #selector(showAddTaskAlert)
		)

		view.addSubview(tableViewTasklist)

		tableViewTasklist.delegate = self
		tableViewTasklist.dataSource = self
	}

	private func makeTableView() -> UITableView {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TaskCell")
		return tableView
	}

	@objc private func showAddTaskAlert() {
		let alertController = UIAlertController(
			title: "New Task",
			message: "Enter task details",
			preferredStyle: .alert
		)

		alertController.addTextField { textField in
			textField.placeholder = "Task Title"
		}

		alertController.addTextField { textField in
			textField.placeholder = "Task description"
		}

		let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
			guard let self = self,
				  let titleField = alertController.textFields?[0],
				  let descriptionField = alertController.textFields?[1],
				  let title = titleField.text, !title.isEmpty else { return }

			let description = descriptionField.text ?? ""

			self.presenter?.didAddTask(title: title, description: description)
		}

		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

		alertController.addAction(saveAction)
		alertController.addAction(cancelAction)
		present(alertController, animated: true, completion: nil)
	}

	private func layout() {
		NSLayoutConstraint.activate([
			tableViewTasklist.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableViewTasklist.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			tableViewTasklist.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableViewTasklist.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
}

// MARK: - ITasklistViewController

extension TasklistViewController: ITasklistViewController {
	func displayTasks(_ tasks: [TaskToDo]) {
		self.tasks = tasks
		print("displayTasks")
		print(self.tasks)
		tableViewTasklist.reloadData()
	}

	func addTaskToView(_ task: TaskToDo) {
		tasks.append(task)
		let indexPath = IndexPath(row: tasks.count - 1, section: 0)
		tableViewTasklist.insertRows(at: [indexPath], with: .automatic)
	}

	func updateTaskInView(_ task: TaskToDo) {
		guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
		tasks[index] = task
		let indexPath = IndexPath(row: index, section: 0)
		tableViewTasklist.reloadRows(at: [indexPath], with: .automatic)
	}

	func removeTaskFromView(_ task: TaskToDo) {
		guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
		tasks.remove(at: index)
		let indexPath = IndexPath(row: index, section: 0)
		tableViewTasklist.deleteRows(at: [indexPath], with: .automatic)
	}
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension TasklistViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		tasks.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
		let task = tasks[indexPath.row]

		var cellConfiguration = UIListContentConfiguration.cell()
		cellConfiguration.text = task.title
		cellConfiguration.secondaryText = task.createdAt?.formatted()

		cell.contentConfiguration = cellConfiguration
		cell.accessoryType = task.isCompleted ? .checkmark : .none

		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let task = tasks[indexPath.row]
		presenter?.didSelectTask(task)
	}

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let task = tasks[indexPath.row]
			presenter?.didDeleteTask(task)

			tasks.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
		}
	}
}
