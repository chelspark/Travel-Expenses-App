# workshop

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## How to add firebase authnetication to your app
1. Set up a Firebase project via the Firebase console https://console.firebae.google.com
2. Install the firebase command line tool https://firebase.google.com/docs/cli (this is done globally)
   1. this is already done 
3. Login with the firebase cli: firebase login
4. Install the flutterfire command line tools: dart pub global activate flutterfire_cli
5. Configure your local project to link to the Firebase project you just created: flutterfire configure
   1. This will ask you whihc platforms you want to configure and creates some configuration files in those sub-folders
6. Add firebase auth to th project dependencies: flutter pub add firebase auth
7. Add the code to call the firebase auth services
8. add firebase auth mocks: flutter pub add firebase_auth_mocks
   1. [flutter pub add firebase_auth_mocks](https://pub.dev/packages/firebase_auth_mocks/install)
9. add firebase core: flutter pub add firebase_core
   1.  https://firebase.google.com/docs/flutter/setup?platform=ios


## Builidng Flutter APps with Firebase in CI

What You're Setting Up
You're going to:
- Secure your Firebase config with GitHub secrets (instead of uploading it)
- Automatically build your Flutter APK using GitHub Actions when you push to main
- Remove sensitive files from your repository

Step-by-Step Setup
1. Generate a Firebase CI Token
On your local machine (Terminal), run:

        firebase login:ci

- It will open a browser window to log in to Firebase.

- After login, you'll get a long token string like:

        1//0gHoUemkuYWA...[rest of token]

✅ Save this somewhere temporarily. You'll use it in Step 4.


2. Find Your Firebase Project ID
Go to **Firebase Console** and open your project.
Your Project ID will look something like: car-spotter-12345

✅ Copy it — you'll use it in Step 4 too.


3. Delete Sensitive Config Files
In your Flutter project directory, delete these files:

        android/app/google-services.json
        ios/Runner/GoogleService-Info.plist
        lib/firebase_options.dart
        firebase.json

Then edit your .gitignore file to add:

        # Firebase configuration files
        **/google-services.json
        **/GoogleService-Info.plist
        lib/firebase_options.dart
        firebase.json

⚠️ If you’ve already pushed these files, they are still in Git history. For full security, consider **making a new Firebase project**.


4. Add GitHub Repository Secrets
In your GitHub repository:

- 1. Go to Settings

- 2. Click Secrets and variables → Actions

- 3. Click "New repository secret"

Add these two secrets:

Name	               Value
FIREBASE_TOKEN	       (your token from Step 1)
FIREBASE_PROJECT_ID	   (your Firebase Project ID)


5. Create GitHub Action Workflow
In your project repo, create this file (or modify an existing one):

        .github/workflows/flutter_build.yml

Paste this sample workflow:

        name: Build Flutter APK

        on:
        push:
            branches:
            - main

        jobs:
        build:
            runs-on: ubuntu-latest

            steps:
            - uses: actions/checkout@v3

            - name: Set up Flutter
                uses: subosito/flutter-action@v2
                with:
                flutter-version: '3.19.1' # Or your version

            - name: Install dependencies
                run: flutter pub get

            - name: Configure Firebase
                run: flutterfire configure --project=$FIREBASE_PROJECT_ID --token=$FIREBASE_TOKEN --platforms=android --yes

            - name: Build APK
                run: flutter build apk

            - name: Upload APK
                uses: actions/upload-artifact@v3
                with:
                name: app-release.apk
                path: build/app/outputs/flutter-apk/app-release.apk

📝 If your Flutter project is inside a sub-folder (e.g., client/), add:

        defaults:
        run:
            working-directory: client

Just after jobs: build:.


6. Test it!
- 1. Commit and push your changes to the main branch.

- 2. Go to the "Actions" tab in GitHub.

- 3. Wait for the build to finish.

- 4. At the bottom of the completed run, you should see a downloadable app-release.apk.