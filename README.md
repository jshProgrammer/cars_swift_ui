# cars_swift_ui

## Overview

This application provides a graphical user interface displaying a collection of current cars. It has been developed using SwiftUI and serves as a project to reinforce and practice fundamental SwiftUI concepts and features. Furthermore, users can interact by signing in with email and password as well as with Google and GitHub. Sign in with Apple has only been prepared due to the lack of a charged development account. Authenticated users are then allowed to publish car ratings visible for all users.
Please note that the information about the cars could be incorrected as they have been created with the help of ChatGPT for testing purposes. Some images are AI-created as well.

## Features

- Interactive and visually appealing UI to showcase modern cars with dark mode support

- List and detailed views for each car model

- Responsive layout adapting to different screen sizes

- Use of SwiftUI components such as List, NavigationView, AsyncImage, GeometryReader and more

- Advanced filtering and search functionality

- Allow users to save their favorite cars on the local device

- Integrate authentication with Firebase

- Publish car ratings as authenticated users

- Enhanced animations for a more dynamic experience (see Login page)

## Technologies Used

- SwiftUI - Declarative UI framework for building modern iOS applications

- Swift - Programming language for iOS development

- SwiftData - Framework for persistent data storage in SwiftUI applications

- Xcode - IDE for Swift development

- Firebase Authentication - Backend solution by Google for user authentication, supporting sign-in methods like Email/Password, Google, GitHub, and Apple Sign-In

- Firebase Firestore - cloud-based NoSQL database for scalable and real-time synchronized data

## User Interface Preview

## Purpose

This project was created as a learning exercise to practice and solidify SwiftUI skills, focusing on:

- Deepening understanding of MVVM architecture pattern

- Implementing navigation and state management including annotations like @State, @StateObject, @Publisher, @ObservedObject with Combine

- Integrating authentication frameworks

- Utilizing newly published SwiftData framework instead of CoreData

- Enhancing UI with animations and gestures

## Installation

1. Clone the repository:
```
git clone https://github.com/jshProgrammer/car-showcase-swiftui.git
```
2. Open the project in Xcode.

3. Create a new Firebase project with Firestore and Sign in with the services mentioned above

4. Insert the *GoogleService-Info* file that includes the necessary api keys in the project folder

5. Insert the api keys for signing in as URL Types (see https://firebase.google.com/docs/auth/ios/github-auth?hl=de)
   
6. Build and run the app using an iOS Simulator or a physical device.

## Future Enhancements

- Integration of a backend service for fetching real-time car data

- Show historical pricing data and best deals, with a forecasting option as well

- Allow users to sell their car via the app, including vehicle accessories

- Provide widgets

- Offline suppport

## Contribution

If you'd like to contribute to this project, feel free to submit a pull request or open an issue to discuss potential improvements.
