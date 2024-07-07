# MovieDBList

Welcome to the MovieDBList project! This project demonstrates a two-screen iOS application using SwiftUI and UIKit, along with networking and continuous integration setup.

# Project Structure
**List Screen:** Implemented using SwiftUI to display a list of movies.
<img src="https://github.com/yeniBabatunde/MovieDBList/assets/92518636/34e95004-7b5c-41be-a1bd-d2f77a099f84" width="200" />

**Description Screen:** Implemented using UIKit to show the details of a selected movie.
<img src="https://github.com/yeniBabatunde/MovieDBList/assets/92518636/c782f66a-6fe9-4001-a10b-70884b1cccd8" width="200" />

**Networking:** Handled with URLSession via a reusable package called NetworkHandling, installed using Swift Package Manager (SPM).
**Image Caching:** Images are cached using FileManager to enhance performance and reduce network calls.
**UI Constraints:** Managed using SnapKit for the UIKit components.
**Continuous Integration: **Basic CI script setup using GitHub Actions to clean and build the application.
**Unit Tests:** Unit tests are written to cover different success and failure scenarios.

# Installing Steps
Clone the Repository

bash
Copy code
git clone https://github.com/yeniBabatunde/MovieDBList.git
cd MovieDBList
Open the Project in Xcode

bash
Copy code
open MovieDBList.xcodeproj
# Install Dependencies

Ensure you have Xcode installed on your machine.
Dependencies are managed using **Swift Package Manager (SPM)** and **SnapKit** is included as a dependency.
Build and Run the Project

Select the appropriate target and device, then build and run the project using Xcode.
Usage
Launch the application to see a list of movies displayed using SwiftUI.
Tap on a movie to view its details on a screen implemented with UIKit.
Continuous Integration
A basic CI script is included in the repository to clean and build the application using GitHub Actions. The script is located in https://github.com/yeniBabatunde/MovieDBList/blob/main/.github/workflows/ios.yml.

**Unit Testing**
Unit tests are written to cover various success and failure scenarios. These tests ensure the robustness of the networking and UI components.
