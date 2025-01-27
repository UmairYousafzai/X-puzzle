import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xpuzzle/domain/entities/states/login_state.dart';
import 'package:xpuzzle/domain/use_cases/auth/password_reset_usecase.dart';

import '../../../domain/use_cases/auth/get_auth_status_usecase.dart';
import '../../../domain/use_cases/auth/login_usecase.dart';
import '../../../domain/use_cases/auth/logout_usecase.dart';
import 'auth_usecase_provider.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetAuthStatusUseCase _getAuthStatusUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  LoginNotifier(
      this._loginUseCase, this._logoutUseCase, this._getAuthStatusUseCase,this._resetPasswordUseCase)
      : super(LoginState());

  Future<void> login() async {
    // resetState();
    try {
      state = state.copyWith(isLoading: true, error: '', isSignedIn: false);

      await _loginUseCase.execute(
        state.email,
        state.password,
      );

      state = state.copyWith(
        isLoading: false,
        isSignedIn: true,
        error: '',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        isSignedIn: false,
      );
    }
  }

  Future<void> logout() async {
    try {
      state = state.copyWith(isLoading: true, error: '');

      await _logoutUseCase.execute();

      state = LoginState(); // Reset to initial state
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  bool isUserLoggedIn() {
    return _getAuthStatusUseCase.execute();
  }

  // Method to update and validate the Email
  void updateEmail(String value) {
    value = value.trim();
    if (value.isEmpty) {
      state = state.copyWith(email: value, emailError: "Email can't be empty");
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


  Future<void> resetPassword() async {
    try {
      state = state.copyWith(isLoading: true, error: '');
      await _resetPasswordUseCase.execute(state.email);
      print("Code sent to ${state.email}");
      state = state.copyWith(
        isLoading: false,
        error: '',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void resetState() {
    state = LoginState();
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  final loginUseCase = ref.watch(loginUseCaseProvider);
  final logoutUseCase = ref.watch(logoutUseCaseProvider);
  final getAuthStatusUseCase = ref.watch(getAuthStatusUseCaseProvider);
  final resetPasswordUseCase=ref.watch(resetPasswordUseCaseProvider);
  return LoginNotifier(loginUseCase, logoutUseCase, getAuthStatusUseCase,resetPasswordUseCase);
});
