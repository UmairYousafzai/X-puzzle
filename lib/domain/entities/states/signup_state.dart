class SignUpState {
  final String firstName;
  final String lastName;
  final String dob;
  final String email;
  final String? firstNameError;
  final String? lastNameError;
  final String? dobError;
  final String? emailError;

  SignUpState({
    this.firstName = '',
    this.lastName = '',
    this.dob = '',
    this.email = '',
    this.firstNameError,
    this.lastNameError,
    this.dobError,
    this.emailError,
  });

  SignUpState copyWith({
    String? firstName,
    String? lastName,
    String? dob,
    String? email,
    String? firstNameError,
    String? lastNameError,
    String? dobError,
    String? emailError,
  }) {
    return SignUpState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dob: dob ?? this.dob,
      email: email ?? this.email,
      firstNameError: firstNameError,
      lastNameError: lastNameError,
      dobError: dobError,
      emailError: emailError,
    );
  }
}
