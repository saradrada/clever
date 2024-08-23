# Clever App 📕

Here's a step-by-step guide on how to clone and run a Swift app from a Git repository. This guide assumes you are familiar with using Git and have Xcode installed on your Mac.

Follow these instructions to set up the project on your local machine.



## Prerequisites

Before you begin, ensure you have the following installed on your machine:

- **macOS**: Version 11.0 (Big Sur) or later
- **Xcode**: Version 12.0 or later
- **Git**: Version control system installed and configured

## Step 1: Clone the Repository

1. **Open Terminal**: You can find Terminal in your Applications folder or by using Spotlight (press `Cmd + Space` and type "Terminal").

2. **Navigate to the directory** where you want to clone the repository. For example:

   ```bash
   cd ~/Projects
   ```

3. **Clone the repository** using the Git command:

   ```bash
   git clone https://github.com/saradrada/clever.git
   ```

4. **Navigate to the cloned repository**:

   ```bash
   cd clever
   ```

## Step 2: Open the Project in Xcode

1. **Launch Xcode**: You can open Xcode from the Applications folder or by using Spotlight.

2. **Open the project**: In Xcode, go to `File > Open` and navigate to the directory where you cloned the repository. Select the `.xcodeproj` or `.xcworkspace` file (depending on the project setup) to open the project.

## Step 3: Install Dependencies 

If the project uses dependencies managed by Swift Package Manager (SPM), you'll need to install them.

1. **Open the project in Xcode** and ensure that the dependencies are listed under `File > Swift Packages`.

2. **Xcode will automatically resolve** and fetch the packages. If not, you can trigger it by going to `File > Swift Packages > Update to Latest Package Versions`.

## Step 4: Build and Run the App

1. **Select a target device or simulator**: In the Xcode toolbar, choose a simulator or connected device from the device selector dropdown.

2. **Build the project**: Click on the build button (the play icon) in the top left corner of Xcode, or use the shortcut `Cmd + B`.

3. **Run the project**: After the build succeeds, the app will automatically launch on the selected device or simulator. If not, click the run button (play icon) to start the app.

## Step 5: Troubleshooting

If you encounter any issues, here are some common troubleshooting steps:

- **Clean the build**: If you run into build errors, try cleaning the project by going to `Product > Clean Build Folder` or using the shortcut `Cmd + Shift + K`.

- **Check for updates**: Ensure Xcode and any dependencies are up to date.

- **Contact the developers**:
  - Sara Ortiz Drada (iOS Developer) [saraodrada@gmail.com](mailto:saraodrada@gmail.com)
  - Yesid Lopez (Machine Learning Engineer) [yesid.leonardo.lopez@hotmail.com](mailto:yesid.leonardo.lopez@hotmail.com) 

---

That's it! You should now have the Clever app running on your local machine.
