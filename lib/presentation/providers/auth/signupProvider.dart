import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xpuzzle/domain/use_cases/auth/signup_usecase.dart';
import 'package:xpuzzle/presentation/providers/auth/auth_usecase_provider.dart';

import '../../../domain/entities/states/signup_state.dart';

class SignUpNotifier extends StateNotifier<SignUpState> {
  final SignUpUseCase _signUpUseCase;

  SignUpNotifier(this._signUpUseCase) : super(SignUpState());

  Future<void> signUp() async {
    try {
      state = state.copyWith(isLoading: true, error: '');

      await _signUpUseCase.execute(
        state.email,
        state.password,
      );

      state = state.copyWith(
        isLoading: false,
        isSignedUp: true,
        error: '',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        isSignedUp: false,
      );
    }
  }

// Method to update and validate the First Name
  void updateFirstName(String value) {
    value = value.trim();
    if (value.isEmpty) {
      state = state.copyWith(
          firstName: "", firstNameError: 'First Name cannot be empty');
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
      state = state.copyWith(firstName: value, firstNameError: "");
    }
  }

// Method to update and validate the Last Name
  void updateLastName(String value) {
    value = value.trim();
    if (value.isEmpty) {
      state = state.copyWith(
          lastName: "", lastNameError: 'Last Name cannot be empty');
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
      state = state.copyWith(lastName: value, lastNameError: "");
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
      state = state.copyWith(dob: value, dobError: ""); // Clear error if valid
    }
  }

  // Method to update and validate the Email
  void updateEmail(String value) {
    value = value.trim();
    if (value.isEmpty) {
      state = state.copyWith(email: "", emailError: "Email can't be empty!");
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
          password: "", passwordError: 'Password cannot be empty');
    } else if (value.length < 8) {
      state = state.copyWith(
          password: value,
          passwordError: "Password must be at least 8 characters");
    } else if (!RegExp(
            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$')
        .hasMatch(value)) {
      state = state.copyWith(
          passwordError:
              "Password must include upper, lower, number, and special character");
    } else {
      state = state.copyWith(password: value, passwordError: "");
    }
  }

  void updateConfirmPassword(String value) {
    value = value.trim();
    if (value.isEmpty) {
      state = state.copyWith(
          confirmPassword: "",
          confirmPasswordError: "Confirm Password cannot be empty");
    } else if (value != state.password) {
      state = state.copyWith(
          confirmPassword: value,
          confirmPasswordError: "Passwords do not match");
    } else {
      state = state.copyWith(confirmPassword: value, confirmPasswordError: "");
    }
  }

  void resetState() {
    state = SignUpState();
  }
}

final signUpProvider =
    StateNotifierProvider<SignUpNotifier, SignUpState>((ref) {
  final signoutUseCase = ref.watch(signUpUseCaseProvider);
  return SignUpNotifier(signoutUseCase);
});
