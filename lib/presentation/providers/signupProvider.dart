import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/states/signup_state.dart';

class SignUpNotifier extends StateNotifier<SignUpState> {
  SignUpNotifier() : super(SignUpState());

  // Method to update and validate the First Name
  void updateFirstName(String value) {
    value = value.trim();
    if (value.isEmpty) {
      state = state.copyWith(firstNameError: 'First name cannot be empty');
    } else if (value.length < 2) {
      state = state.copyWith(firstNameError: 'First name must be at least 2 characters long');
    } else {
      state = state.copyWith(firstName: value, firstNameError: null); // Clear error if valid
    }
  }

  // Method to update and validate the Last Name
  void updateLastName(String value) {
    value = value.trim();
    if (value.isEmpty) {
      state = state.copyWith(lastNameError: 'Last name cannot be empty');
    } else if (value.length < 2) {
      state = state.copyWith(lastNameError: 'Last name must be at least 2 characters long');
    } else {
      state = state.copyWith(lastName: value, lastNameError: null); // Clear error if valid
    }
  }

  // Method to update and validate the DOB
  void updateDOB(String value) {
    value = value.trim();
    if (value.isEmpty) {
      state = state.copyWith(dobError: 'Date of Birth cannot be empty');
    } else if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
      state = state.copyWith(dobError: 'Date of Birth must be in the format DD/MM/YYYY');
    } else {
      state = state.copyWith(dob: value, dobError: null); // Clear error if valid
    }
  }

  // Method to update and validate the Email
  void updateEmail(String value) {
    value = value.trim();
    if (value.isEmpty) {
      state = state.copyWith(emailError: 'Email cannot be empty');
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
      state = state.copyWith(emailError: 'Enter a valid email address');
    } else {
      state = state.copyWith(email: value, emailError: null); // Clear error if valid
    }
  }
}

// Provider to manage the SignUpNotifier
final signUpProvider = StateNotifierProvider<SignUpNotifier, SignUpState>(
      (ref) => SignUpNotifier(),
);




