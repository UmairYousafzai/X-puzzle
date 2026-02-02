# X-Puzzle 🧩

A Flutter-based math puzzle game that challenges players to solve multiplication puzzles within a time limit. Test your mathematical skills and improve your mental arithmetic through engaging gameplay.

## 📱 About the App

X-Puzzle is an interactive math test application where players solve multiplication puzzles by finding two numbers that multiply to a given result. The app features multiple difficulty levels, timer functionality, and progress tracking to create an engaging learning experience.

## ✨ Features

### 🎮 Core Gameplay
- **Math Puzzles**: Solve multiplication puzzles by entering two numbers that multiply to the target result
- **Multiple Levels**: Progress through 4 different difficulty levels (Level 1-4)
- **Timer System**: 
  - 5-minute countdown timer for each puzzle
  - Play/Pause functionality
  - Reset option to restart the timer
- **Progress Tracking**: Visual progress bar to track your completion status

### 🎨 User Interface
- **Landing Screen**: Welcome screen with style selection dropdown
- **Home Screen**: 
  - List and Grid view toggle for session selection
  - Personalized greeting
  - Profile picture support
- **Game Screen**: 
  - Clean, intuitive puzzle interface
  - Real-time timer display
  - Navigation between levels
- **Completion Screen**: Celebration screen when quiz is completed
- **Results Screen**: View your performance and results

### 🛠️ Technical Features
- **State Management**: Built with Riverpod for efficient state management
- **Responsive Design**: Adapts to different screen sizes
- **Custom Theming**: Beautiful UI with custom colors and Google Fonts
- **SVG Support**: Scalable vector graphics for crisp icons
- **Splash Screen**: Native splash screen integration

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.4.3 <4.0.0)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- An IDE with Flutter support (VS Code, Android Studio, etc.)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/X-puzzle.git
   cd X-puzzle
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── local/               # Local models
│   └── remote/              # Remote/API models
├── providers/               # Riverpod state providers
│   ├── app_provider.dart
│   ├── game_provider.dart   # Game state management
│   ├── game_number_provider.dart
│   ├── level_provider.dart  # Level management
│   └── home_screen_providers.dart
├── screens/                  # App screens
│   ├── landing_screen.dart  # Welcome/landing screen
│   ├── home_screen/         # Home screen components
│   ├── game_screen/         # Game screen components
│   ├── quiz_completion_screen.dart
│   ├── results_screen.dart
│   └── widgets/             # Reusable widgets
├── service/                 # API services
├── theme/                   # App theming
│   ├── app_theme.dart
│   └── colors.dart
└── utils/                   # Utilities
    └── constants.dart
```

## 🎯 How to Play

1. **Start the App**: Launch the app and you'll see the landing screen
2. **Select Style**: Choose your preferred style from the dropdown
3. **Navigate to Home**: Click "Continue" to proceed to the home screen
4. **Select Level**: Choose a level/session from the home screen (toggle between list and grid view)
5. **Solve Puzzles**: 
   - Enter two numbers in the input fields
   - The numbers should multiply to equal the target number (shown as "X × 18 = 9" format)
   - Use the number buttons or keyboard to input values
6. **Manage Timer**: 
   - Use the play button to start the timer
   - Pause when needed
   - Reset to restart the 5-minute countdown
7. **Navigate Levels**: Use the back/next buttons to move between levels
8. **Complete Quiz**: Finish all levels to see the completion screen

## 🛠️ Technologies Used

- **Flutter**: Cross-platform mobile framework
- **Dart**: Programming language
- **Riverpod**: State management solution
- **Google Fonts**: Custom typography
- **Flutter SVG**: SVG image support
- **Dio**: HTTP client for API calls
- **Gap**: Spacing widget for layouts

## 📦 Dependencies

Key dependencies include:
- `flutter_riverpod: ^2.5.1` - State management
- `google_fonts: ^6.2.1` - Custom fonts
- `flutter_svg: ^2.0.10+1` - SVG support
- `dio: ^5.7.0` - HTTP client
- `gap: ^3.0.1` - Layout spacing
- `flutter_native_splash: ^2.2.16` - Splash screen

## 🎨 App Screenshots
<img width="379" height="788" alt="Onboarding" src="https://github.com/user-attachments/assets/3b706793-25ff-48a6-b6df-96803a67960f" />
<img width="379" height="788" alt="Onboarding (1)" src="https://github.com/user-attachments/assets/7f1ffcd3-4412-4026-b629-81be961723da" />
<img width="384" height="788" alt="Onboarding (2)" src="https://github.com/user-attachments/assets/01cc69db-ed34-42a1-bd18-d980576eeabb" />
<img width="384" height="788" alt="Onboarding (6)" src="https://github.com/user-attachments/assets/5fd2b82d-4a9e-497e-b07f-125a18206634" />
<img width="379" height="788" alt="Onboarding (3)" src="https://github.com/user-attachments/assets/b4bcb03b-017e-420d-bebd-29122e2af91d" />
<img width="379" height="788" alt="Onboarding (4)" src="https://github.com/user-attachments/assets/a9195c88-b85a-4f0e-b15e-006c927de929" />


## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## 📝 License


## 👤 Author

**Your Name**
- GitHub: (https://github.com/UmairYousafzai)


---

**Note**: This is a math test/puzzle application designed to improve mental arithmetic skills through gamification. Enjoy solving puzzles and improving your math skills! 🎓✨
