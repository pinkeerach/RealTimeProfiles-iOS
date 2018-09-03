# RealTimeProfiles
RealTimeProfiles is an iPhone application that demonstrates a basic implementation of the Firebase Realtime Database to create and list profiles in a real time manner. In other words, the app is always connected, and changes made to the profile list will be automatically reflected in any other instances where the app is running.

## Setup
### Xcode
The current codebase is written in Swift 4 using Xcode 9.4. Use the RealTimeProfiles workspace to make full use of the committed pods.

### Firebase Config
After cloning the repo, you'll quickly notice that the Firebase configuration plist is missing. This is intentional to ensure you use the appropriate Firebase account (and don't run up charges on mine).

Before you attempt to run the app, you'll need to setup a Firebase project for the app, and add your own `GoogleService-Info.plist` to the `RealTimeProfiles/configs` folder. You can [download them from Firebase](https://support.google.com/firebase/answer/7015592). 

### Authentication
Security should always be considered up front. As such, this app requires authentication, albeit a very simple implementation for now. 

In your Firebase console, you'll need to configure [basic email/password authentication](https://firebase.google.com/docs/auth/ios/password-auth) and create an account to get past the log in screen.

The next version of the app will support registration within the app, including the option for 3rd party identity providers. 

### Realtime Database
This app relies on the oft-used Realtime Database offering from Firebase. At the origination of this app, Firebase Cloud Firestore was still in beta, and I opted for a more stable and often used product (i.e. lots of developers have documented solutions to problems they've faced). 

The app is configured to use a JSON structure like this:
```JSON
{
  "profiles" : {
    "-LLM51HEhL3MjQFNd46n" : {
      "age" : 87,
      "firstName" : "Alan",
      "gender" : "male",
      "hobbies" : "philosophy, writing, meditation",
      "lastName" : "Watts",
      "profileImage" : "https://www.prandom.com/images/Alan_Watts.jpg"
    }
  }
}
```

The next version of the app will include a switch over to Cloud Firestore as JSON data storage has significant limitations in scaling.

### Cocoapods
The app is already configured to use Cocoapods. In fact, all the dependencies are committed for your convenience. While I don't typically prefer this as best practice in production apps, it simplifies sharing codebases, especially when you know the codebase won't be maintained regularly over time.

## Product Backlog
This implementation of various pieces of the Firebase offering had me thinking of a lot of different ways I could make this app better. In other words, here's a list of TODOs.

### Authorization/Authentication
* Implement New User Registration
* Implement 3rd Party Identity Providers (Google, etc.)
* Create more granular security rules

### Profile List
* Fix layout issues on collection view cells
* Improve filtering to handle other scenarios
* Improve UI indicators showing what filters & sorts are selected
* Implement custom flow layout to support device rotation
 
### Create, Update, Delete Profiles
* Merge the Create Profile and Profile Detail screens
* Convert age to a calculation based on Date of Birth
* Convert hobbies to a list of individual hobbies instead of a single string field
* Make profile image loading more efficient

### Other
* Implement remote config
* Disallow unsecured URLs (i.e. require https)
* Hire a designer!