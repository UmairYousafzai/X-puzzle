
import '../../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String firstName,
    required String lastName,
    required String dob,
    required String email,
  }) : super(
    firstName: firstName,
    lastName: lastName,
    dob: dob,
    email: email,
  );

  // Method to convert UserModel to JSON
  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'dob': dob,
    'email': email,
  };

  // Factory method to create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      dob: json['dob'],
      email: json['email'],
    );
  }
}
