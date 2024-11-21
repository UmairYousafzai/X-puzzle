import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/states/signup_state.dart';

class SignUpNotifier extends StateNotifier<SignUpState> {
  SignUpNotifier() : super(SignUpState());

// Method to update and validate the First Name
  void updateFirstName(String value) {
    value = value.trim();
    if (value.isEmpty) {
      state = state.copyWith(
          firstName: '', firstNameError: 'First Name cannot be empty');
    } else if (value.length < 2 || value.length > 50) {
      state = state.copyWith(
          firstName: value,
          firstNameError:
              'First Name must be between 2 and 50 characters long');
    } else if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(value)) {
      state = state.copyWith(
          firstName: value,
          firstNameError:
              'First Name can only contain letters, spaces, apostrophes, and hyphens');
    } else {
      state = state.copyWith(firstName: value, firstNameError: null);
    }
  }

// Method to update and validate the Last Name
  void updateLastName(String value) {
    value = value.trim();
    if (value.isEmpty) {
      state = state.copyWith(
          lastName: '', lastNameError: 'Last Name cannot be empty');
    } else if (value.length < 2 || value.length > 50) {
      state = state.copyWith(
          lastName: value,
          lastNameError: 'Last Name must be between 2 and 50 characters long');
    } else if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(value)) {
      state = state.copyWith(
          lastName: value,
          lastNameError:
              'Last Name can only contain letters, spaces, apostrophes, and hyphens');
    } else {
      state = state.copyWith(lastName: value, lastNameError: null);
    }
  }

  // Method to update and validate the DOB
  void updateDOB(String value) {
    value = value.trim();
    if (value.isEmpty) {
      state = state.copyWith(dobError: 'Date of Birth cannot be empty');
    } else if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
      // Updated regex to match YYYY-MM-DD
      state = state.copyWith(
          dobError: 'Date of Birth must be in the format YYYY-MM-DD');
    } else {
      state =
          state.copyWith(dob: value, dobError: null); // Clear error if valid
    }
  }

  // Method to update and validate the Email
  void updateEmail(String value) {
    value = value.trim();
    if (value.isEmpty) {
      state = state.copyWith(email: value, emailError: null);
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      state = state.copyWith(
          email: value, emailError: 'Enter a valid email address');
    } else {
      state = state.copyWith(
          email: value, emailError: null); // Clear error if valid
    }
  }

  void resetState() {
    state = SignUpState();
  }
}

// Provider to manage the SignUpNotifier
final signUpProvider = StateNotifierProvider<SignUpNotifier, SignUpState>(
  (ref) => SignUpNotifier(),
);
