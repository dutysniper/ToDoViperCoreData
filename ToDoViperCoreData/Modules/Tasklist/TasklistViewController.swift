//
//  TasklistViewController.swift
//  ToDoViperCoreData
//
//  Created by Константин Натаров on 26.08.2024.
//

import UIKit

protocol ITasklistViewController {
	func displayTasks(_ tasks: [Task])
	func addTaskToView(_ task: Task)
	func updateTaskInView(_ task: Task)
	func removeTaskFromView(_ task: Task)
}


final class TasklistViewController: UIViewController {
	// MARK: - Public properties

	var tasks: [Task] = []

	// MARK: - Dependencies

	var presenter: ITasklistPresenter?
	// MARK: - Private properties

	private lazy var tableViewTasklist: UITableView = makeTableView()

	// MARK: - Initialization

	// MARK: - Lifecycle

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .blue
	}

	// MARK: - Public methods

	// MARK: - Private methods

}

// MARK: - ITasklistViewController

extension TasklistViewController: ITasklistViewController {
	func displayTasks(_ tasks: [Task]) {
		self.tasks = tasks
		tableViewTasklist.reloadData()
	}

	func addTaskToView(_ task: Task) {

	}

	func updateTaskInView(_ task: Task) {

	}

	func removeTaskFromView(_ task: Task) {

	}
}

extension TasklistViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		tasks.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
		let task = tasks[indexPath.row]

		var cellConfiguration = UIListContentConfiguration.cell()
		cellConfiguration.text = task.title

		cell.contentConfiguration = cellConfiguration
		cell.accessoryType = task.isCompleted ? .checkmark : .none

		return cell
	}


}

// MARK: - Setup UI

private extension TasklistViewController {
	func setupUI() {
		title = "ToDo List"
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem:
				.add,
				target: self,
				action: #selector(showAddTaskAlert)
		)

		view.addSubview(tableViewTasklist)

		tableViewTasklist.delegate = self
		tableViewTasklist.dataSource = self

	}

	func makeTableView() -> UITableView {
		let tableView = UITableView()

		tableView.translatesAutoresizingMaskIntoConstraints = false

		tableView.register(UITableView.self, forCellReuseIdentifier: "TaskCell")

		return tableView
	}

	@objc func showAddTaskAlert() {
		let alertController = UIAlertController(title: "New Task", message: "Enter task details", preferredStyle: .alert)

		alertController.addTextField { textField in
			textField.placeholder = "Task Title"
		}

		alertController.addTextField { textField in
			textField.placeholder = "Task description"
		}

		
	}
}

// MARK: - Layout UI

private extension TasklistViewController {
	func layout() {
		NSLayoutConstraint.activate(
			[
				tableViewTasklist.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
				tableViewTasklist.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
				tableViewTasklist.leadingAnchor.constraint(equalTo: view.leadingAnchor),
				tableViewTasklist.trailingAnchor.constraint(equalTo: view.trailingAnchor)
			]
		)
	}
}
