# Epoch
* A flutter app to manage the timetable of students of JIIT.
* This is the UI implementation of the timetable Rest API deployed on Heroku.
* The app gives a friendly interface that can be used to see everyday timetable with all details about the room and faculty.

# Dependencies
Flutter framework has been used to build a native app.
* Shared Preference - To store local user data
* http - For handling http requests in flutter
* flutter_launcher_icons - For custom flutter app icon.

# Running the App

The app requires latest flutter repository and dart engine to be already set up and running. Further, for running the app, you must have an emulator or USB debugging on physical device.

Check if flutter has been set up correctly by following: 

```
flutter doctor
```


Firstly, clone the repository and open the repository in terminal.
```
git clone https://github.com/ajayKumar99/Epoch.git

cd epoch
```

Run the following command to get the required dependencies from the pubspec.yaml file.

```
flutter pub get
```

Next, run the app by

```
flutter run
```
