class User {
  final String firstName;
  final String lastName;
  final String dob;
  final String email;

  User({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'dob': dob,
    'email': email,
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      dob: json['dob'],
      email: json['email'],
    );
  }
}
