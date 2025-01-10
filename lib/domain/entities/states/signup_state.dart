class SignUpState {
  final String firstName;
  final String lastName;
  final String dob;
  final String email;
  final String password;
  final String confirmPassword;
  final String? firstNameError;
  final String? lastNameError;
  final String? dobError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  final bool isLoading; // Added for loading state
  final bool isSignedUp; // Added for signup success
  final String? error; // Added for general errors

  SignUpState({
    this.firstName = '',
    this.lastName = '',
    this.dob = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.firstNameError,
    this.lastNameError,
    this.dobError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
    this.isLoading = false, // Initialize new fields
    this.isSignedUp = false,
    this.error,
  });

  SignUpState copyWith({
    String? firstName,
    String? lastName,
    String? dob,
    String? email,
    String? password,
    String? confirmPassword,
    String? firstNameError,
    String? lastNameError,
    String? dobError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    bool? isLoading, // Add to copyWith
    bool? isSignedUp,
    String? error,
  }) {
    return SignUpState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dob: dob ?? this.dob,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      firstNameError: firstNameError ?? this.firstNameError,
      lastNameError: lastNameError ?? this.lastNameError,
      dobError: dobError ?? this.dobError,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      confirmPasswordError: confirmPasswordError ?? this.confirmPasswordError,
      isLoading: isLoading ?? this.isLoading,
      // Include new fields
      isSignedUp: isSignedUp ?? this.isSignedUp,
      error: error ?? this.error,
    );
  }
}
