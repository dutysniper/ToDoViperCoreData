
# ToDoViperCoreData

ToDoViperCoreData is a task management application that demonstrates the usage of the VIPER architecture with Core Data for persistent storage. The app is designed to help users manage their daily tasks effectively while showcasing modern iOS development practices.

## Features

- **Task Management**: Add, edit, and delete tasks.
- **Task Completion**: Mark tasks as completed.
- **Persistent Storage**: All tasks are saved using Core Data, ensuring that data persists across app launches.
- **Light and Dark Mode Support**: The app automatically adapts to the user's system appearance preference.
- **Separation of Concerns**: Implements the VIPER architecture for clean, maintainable code.

## Screenshots

![Light Mode](screenshots/light_mode.png)
![Dark Mode](screenshots/dark_mode.png)

## VIPER Architecture

The application follows the VIPER architecture, which stands for:

- **View**: The UI layer, responsible for displaying the data and interacting with the user.
- **Interactor**: Handles the business logic of the application.
- **Presenter**: Acts as a mediator between the View and Interactor. It formats data received from the Interactor to be displayed by the View.
- **Entity**: The data model, representing the structure of the data in the application.
- **Router**: Manages navigation and routing between screens.

## Tech Stack

### Language
- **Swift**: The entire application is written in Swift, leveraging its modern features for safe and performant code.

### UI
- **UIKit**: Utilized for building the user interface, including custom views and layouts.

### Data Persistence
- **Core Data**: Used for storing and managing tasks persistently on the device.

### Networking
- **URLSession**: Implements basic networking tasks for API interactions.

### Dependency Management
- **CocoaPods** (if applicable): Used for managing third-party dependencies.

### Unit Testing
- **XCTest**: The app includes unit tests to ensure the stability and reliability of the code, focusing on testing the business logic in the Interactor and Presenter layers.

## Installation

To run this project, you will need:

1. **Xcode**: Version 12.0 or later.
2. **CocoaPods** (if you're using any third-party libraries).

Clone the repository and open the `.xcodeproj` file in Xcode:

```bash
git clone https://github.com/username/ToDoViperCoreData.git
cd ToDoViperCoreData
open ToDoViperCoreData.xcodeproj
```

If you are using CocoaPods:

```bash
pod install
open ToDoViperCoreData.xcworkspace
```

## Usage

1. **Run the app**: Use the Xcode simulator or a physical device.
2. **Add tasks**: Enter a task title and description, then save it.
3. **Mark tasks as completed**: Use the switch to mark a task as completed.
4. **Delete tasks**: Swipe left on a task to delete it.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue with suggestions and improvements.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

For any inquiries or questions, feel free to reach out:

- Email: yourname@example.com
- GitHub: [yourusername](https://github.com/yourusername)
