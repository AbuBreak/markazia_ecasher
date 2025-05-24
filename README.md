# Markazia E-Casher

Markazia E-Casher is a cross-platform Flutter application designed for managing branch services and user authentication for Markazia. The app supports multiple platforms, including Android and iOS.

## Features

- **User Authentication:** Secure login for employees.
- **Branch Management:** View and select branches, with support for offline caching.
- **Service Management:** Update and manage branch service statuses.
- **Localization:** Supports English and Arabic languages.
- **Responsive UI:** Adapts to different screen sizes and platforms.

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart SDK (comes with Flutter)
- Platform-specific requirements (Android Studio, Xcode, etc.)

### Installation

1. **Clone the repository:**
   ```sh
   git clone https://github.com/AbuBreak/markazia-ecasher.git
   cd markazia-ecasher

2. Install dependencies:
   ```sh
      flutter pub get

4. Run the app:
   For IOS/Android:
   ```sh
     flutter run

### Configuration
- API Endpoints:
Update API URLs in AppConstent if needed.

- Localization:
Edit l10n.yaml and translation files in l10n for additional languages.

- State Management
The app uses the Provider package for state management. Providers are set up in provider_setup.dart and registered in main.dart.

### Contributing
1. Fork the repository.
2. Create your feature branch (git checkout -b feature/YourFeature).
3. Commit your changes (git commit -am 'Add some feature').
4. Push to the branch (git push origin feature/YourFeature).
5. Open a pull request.

   
### License
This project is licensed under the MIT License.

## Markazia E-Casher
#### Malik Abubreak
