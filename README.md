<h1>ERP Driver</h1>

  <p>This project is a Flutter application designed for ERP drivers to manage their login, live location sharing, and potentially receive notifications via Firebase Cloud Messaging (FCM).</p>

  <h2>Project Setup</h2>

  <h3>Prerequisites</h3>

  <ul>
    <li>Flutter: Ensure you have Flutter installed on your development machine. Refer to the official documentation for installation instructions: <a href="https://docs.flutter.dev/get-started/install">Flutter Installation</a></li>
    <li>Firebase Project: Set up a Firebase project and enable the required services (Authentication, Firestore, Cloud Messaging). Refer to Firebase documentation for details: <a href="https://console.firebase.google.com/">Firebase Console</a></li>
  </ul>

  <h3>Installation</h3>

  <p>Clone this repository to your local machine.</p>

  <h3>Configuration</h3>

  <p>Replace the placeholder values in `firebase_options.dart` with your Firebase project's configuration details.</p>

  <h2>Running the App</h2>

  <ol>
    <li>Navigate to the project directory in your terminal.</li>
    <li>Run `flutter pub get` to download dependencies.</li>
    <li>Start the development server:
      <ul>
        <li>For Android: `flutter run`</li>
        <li>For iOS: (Assuming you have Xcode and simulators set up) `flutter run --launch-scheme ios`</li>
      </ul>
    </li>
  </ol>

  <h2>Features</h2>

  <ul>
    <li><strong>Login Screen:</strong> Allows drivers to authenticate using Firebase Authentication.</li>
    <li><strong>Live Location Sharing:</strong> Implements a mechanism for drivers to share their real-time location (specific implementation details will depend on your chosen approach).</li>
    <li><strong>Firebase Cloud Messaging (Optional):</strong> If integrated, enables the app to receive notifications from your backend server.</li>
  </ul>