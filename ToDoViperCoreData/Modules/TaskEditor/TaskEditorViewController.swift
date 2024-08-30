//
//  TaskEditorViewController.swift
//  ToDoViperCoreData
//
//  Created by Константин Натаров on 29.08.2024.
//

import UIKit

/// Интерфейс для взаимоедйствия с VC
protocol ITaskEditorViewController: AnyObject {
	func displayTaskDetails(task: TaskToDo)
	func showSaveSuccess()
}

final class TaskEditorViewController: UIViewController {

	// MARK: - Public properties
	// MARK: - Dependencies

	var presenter: ITaskEditorPresenter?

	// MARK: - Private properties

	private lazy var textFieldTitle: UITextField = makeTextField()
	private lazy var textViewDescription: UITextView = makeTextView()
	private lazy var buttonSave: UIButton = makeButton()
	private lazy var switchIsCompleted: UISwitch = makeSwitch()
	private lazy var labelIsCompleted: UILabel = makeLabel()
	// MARK: - Initialization

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		presenter?.loadTaskDetails()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layout()
	}
	// MARK: - Public methods
	// MARK: - Private methods
}

// MARK: - ITaskEditorViewController

extension TaskEditorViewController: ITaskEditorViewController {
	/// Метод для присваивания данных из презентера полям экрана
	func displayTaskDetails(task: TaskToDo) {
		textFieldTitle.text = task.title
		textViewDescription.text = task.details
		switchIsCompleted.isOn = task.isCompleted
	}

	/// Метод для вызова алерта об успехе сохранения задачи
	func showSaveSuccess() {
		let alertController = UIAlertController(title: "Success", message: "Task saved successfully", preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
			self?.navigationController?.popViewController(animated: true)
		}))
		present(alertController, animated: true, completion: nil)
	}
}

// MARK: - Setup UI

private extension TaskEditorViewController {
	/// Метод для настройки UI
	func setupUI() {
		view.backgroundColor = .systemBackground
		view.addSubview(textFieldTitle)
		view.addSubview(textViewDescription)
		view.addSubview(switchIsCompleted)
		view.addSubview(buttonSave)
		view.addSubview(labelIsCompleted)
	}
	/// Метод для создания текстфилда
	func makeTextField() -> UITextField {
		let textField = UITextField()

		textField.placeholder = "Task Title"
		textField.borderStyle = .roundedRect

		textField.translatesAutoresizingMaskIntoConstraints = false

		return textField
	}

	/// Метод для создания текстВью
	func makeTextView() ->  UITextView {
		let textView = UITextView()

		textView.layer.borderColor = UIColor.gray.cgColor
		textView.layer.borderWidth = 1.0
		textView.layer.cornerRadius = 8.0

		textView.translatesAutoresizingMaskIntoConstraints = false

		return textView
	}

	/// Метод для создания свича
	func makeSwitch() -> UISwitch {
		let switchIsCompleted = UISwitch()

		switchIsCompleted.translatesAutoresizingMaskIntoConstraints = false

		return switchIsCompleted

	}

	/// Метод для создания label
	func makeLabel() -> UILabel {
		let label = UILabel()

		label.text = "Completed"
		label.font = UIFont.systemFont(ofSize: 16)
		label.textColor = .label

		label.translatesAutoresizingMaskIntoConstraints = false

		return label
	}

	/// Метод для создания кнопки
	func makeButton() -> UIButton {
		let button = UIButton()

		button.setTitle("Save", for: .normal)
		button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)

		button.translatesAutoresizingMaskIntoConstraints = false

		return button
	}

	@objc func didTapSaveButton() {
		guard let title = textFieldTitle.text, !title.isEmpty else { return }
		
		let description = textViewDescription.text ?? ""
		let isCompleted = switchIsCompleted.isOn

		presenter?.didTapSaveButton(title: title, description: description, isCompleted: isCompleted)
	}
}

// MARK: - Layout

private extension TaskEditorViewController {
	/// Метод для расстановки констрейнтов
	func layout() {
		NSLayoutConstraint.activate([
			textFieldTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			textFieldTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			textFieldTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

			textViewDescription.topAnchor.constraint(equalTo: textFieldTitle.bottomAnchor, constant: 20),
			textViewDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			textViewDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			textViewDescription.heightAnchor.constraint(equalToConstant: 150),

			labelIsCompleted.topAnchor.constraint(equalTo: textViewDescription.bottomAnchor, constant: 20),
			labelIsCompleted.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

			switchIsCompleted.topAnchor.constraint(equalTo: labelIsCompleted.bottomAnchor, constant: 8),
			switchIsCompleted.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

			buttonSave.topAnchor.constraint(equalTo: switchIsCompleted.bottomAnchor, constant: 40),
			buttonSave.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
	}
}
