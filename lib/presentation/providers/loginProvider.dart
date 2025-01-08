import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xpuzzle/domain/entities/states/login_state.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState());

  // Method to update and validate the Email
  void updateEmail(String value) {
    value = value.trim();
    if (value.isEmpty) {
      state = state.copyWith(email: value, emailError: "");
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      state = state.copyWith(emailError: 'Enter a valid email address');
    } else {
      state =
          state.copyWith(email: value, emailError: ""); // Clear error if valid
    }
  }

  void updatePassword(String value) {
    value = value.trim();
    if (value.isEmpty) {
      state = state.copyWith(
          password: value, passwordError: "Password cannot be empty");
    } else if (value.length < 8) {
      state = state.copyWith(
          passwordError: "Password must be at least 8 characters");
    } else if (!RegExp(
            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$')
        .hasMatch(value)) {
      state = state.copyWith(
          passwordError:
              "Password must include upper, lower, number, and special character");
    } else {
      state = state.copyWith(
          password: value, passwordError: ""); // Clear error if valid
    }
  }

  void resetState() {
    state = LoginState();
  }
}

// Provider to manage the SignUpNotifier
final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(),
);
