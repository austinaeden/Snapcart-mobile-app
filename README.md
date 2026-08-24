# E-Commerce Complete Application

A complete e-commerce mobile app built with **Flutter**, **Dart**, and **Firebase**.

**Author:** Austin Aeden
**Project type:** School Project

## About This Project

This app is a school project that demonstrates how to build a full-featured e-commerce mobile application using Flutter for the frontend and Firebase as the backend. It covers everything from onboarding and authentication to browsing products, managing a shopping cart, placing orders, and managing a user profile.

## What the App Does

- **Onboarding** — introduces new users to the app
- **Authentication** — sign up, log in, forgot password, and OTP verification, including Google Sign-In
- **Home Screen Notifications** — greets the user with a notification when they land on the home screen
- **Product Browsing** — fetches products from Firebase and lets users filter them by category
- **Shopping Cart** — add items to cart, view cart contents, and order directly from the cart
- **Checkout** — place orders with Cash on Delivery
- **Shipping Addresses** — add new addresses and select one at checkout
- **Product Options** — choose size and color before adding to cart
- **User Profile** — view and edit profile information
- **Support Chat** — built-in customer support chat powered by Tawk.to
- **Local Notifications** — alerts for order placement, new deals, and new products
- **Reviews** — leave a review once an order has been delivered

## Screens Included

- Onboarding
- Login / Register / Login Success
- Forgot Password / OTP Screen / OTP Verification
- Complete Profile
- Home Page
- Categories Section (Dynamic Tabs)
- Product Details View / Product Description
- Shipping Addresses List + Select Address
- Add Shipping Address
- Show More / Filtered Show More
- Reviews / Add Review
- Orders / Order Item Detail
- Profile / Edit Profile
- Notifications
- Settings
- Support Chat
- Bottom Navigation Bar

## Tech Stack & Packages

**Core:**
- Flutter & Dart
- Firebase (Auth, Firestore, Storage, Messaging)

**Key packages used:**
- `firebase_auth`, `firebase_core`, `firebase_storage`, `cloud_firestore`, `firebase_messaging`
- `get`, `get_it`, `provider` — state management & dependency injection
- `dio`, `http` — networking
- `flutter_local_notifications` — local push notifications
- `flutter_stripe` — payments
- `flutter_tawk` — support chat
- `flutter_rating_bar` — product reviews
- `flutter_svg`, `cached_network_image`, `font_awesome_flutter`, `google_fonts` — UI/media
- `google_sign_in` — Google authentication
- `geocoding`, `geolocator` — location services for shipping addresses
- `image_picker` — profile picture uploads
- `permission_handler` — device permissions
- `shared_preferences` — local storage
- `uuid` — unique ID generation

## Installation Guide

Follow these steps to get the project running on your machine.

### 1. Prerequisites

Before starting, make sure you have installed:

- **Flutter SDK** (stable channel) — [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Dart SDK** (comes bundled with Flutter)
- **Android Studio** or **VS Code** with the Flutter/Dart plugins
- **Git**
- A physical device or emulator/simulator (Android Emulator or iOS Simulator)
- A **Firebase account** — [firebase.google.com](https://firebase.google.com)

Verify your Flutter installation:

```bash
flutter doctor
```

Make sure there are no unresolved issues before continuing.

### 2. Clone the Repository

```bash
git clone <your-repository-url>
cd <project-folder-name>
```

### 3. Install Dependencies

From the project root, run:

```bash
flutter pub get
```

This downloads all the packages listed in `pubspec.yaml`.

### 4. Set Up Firebase

This project needs a Firebase backend to work.

1. Go to the [Firebase Console](https://console.firebase.google.com/) and create a new project.
2. Enable the following services in your Firebase project:
   - **Authentication** (enable Email/Password and Google sign-in methods)
   - **Cloud Firestore** (create a database in test or production mode)
   - **Firebase Storage**
   - **Firebase Cloud Messaging** (for notifications)
3. Register your app with Firebase:
   - **Android:** Add an Android app in the Firebase console using your app's package name (found in `android/app/build.gradle`). Download the generated `google-services.json` file and place it inside the `android/app/` folder.
   - **iOS:** Add an iOS app in the Firebase console using your app's bundle ID. Download the generated `GoogleService-Info.plist` file and place it inside the `ios/Runner/` folder.
4. Install the FlutterFire CLI to auto-generate Firebase configuration (recommended):

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

   This will generate a `firebase_options.dart` file automatically and connect your Flutter app to your Firebase project.

### 5. Configure Support Chat (Optional)

If you want the support chat feature to work, create a free account at [Tawk.to](https://www.tawk.to/) and add your widget's property ID and widget ID where the `flutter_tawk` package is configured in the code.

### 6. Run the App

Connect a device or start an emulator, then run:

```bash
flutter run
```

### 7. Build for Release (Optional)

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## Troubleshooting

- If you see Firebase-related errors, double check that `google-services.json` / `GoogleService-Info.plist` are placed correctly and that `flutterfire configure` completed successfully.
- Run `flutter clean` followed by `flutter pub get` if you run into build cache issues.
- Make sure your Firebase Firestore rules allow read/write access appropriate for testing during development.

## Design Credits

The Splash, Login, Cart, and Description screen designs were adapted from the **Flutter Way** project. Credit to the original author — consider giving them a star:

- Repository: [E-Commerce Complete App - Flutter UI](https://github.com/abuanwar072/E-commerce-Complete-Flutter-UI)
- Preview:

  ![Preview](/intro.gif)

- Photos:

  ![Preview](/photos/1.png)
  ![Preview](/photos/2.png)
  ![Preview](/photos/3.png)
  ![Preview](/photos/4.png)
  ![Preview](/photos/5.png)
  ![Preview](/photos/6.png)
  ![Preview](/photos/7.png)

## Future Improvements

- Integrate real product data
- Build a custom backend
- Add full payment processing
- Voice assistant / GPT integration
- Google Maps live order tracking
- ShipRocket shipping service integration

---

*This project was created as a school project by Austin Aeden.*
