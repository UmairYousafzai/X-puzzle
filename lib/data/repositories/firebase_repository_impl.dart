// firebase_auth_repository_impl.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repositories/firebase_repository.dart';
import '../data_source/remote/firebase_helper.dart';
import '../models/local/user_model.dart';

class FirebaseAuthRepositoryImpl implements FirebaseRepository {
  final FirebaseHelper _firebaseHelper;

  FirebaseAuthRepositoryImpl(FirebaseAuth firebaseAuth, FirebaseFirestore firestore)
      : _firebaseHelper = FirebaseHelper(firebaseAuth, firestore);

  @override
  Future<void> signUpWithEmailPassword(String email, String password) async {
    return _firebaseHelper.signUpWithEmailPassword(email, password);
  }

  @override
  Future<void> signInWithEmailPassword(String email, String password) async {
    return _firebaseHelper.signInWithEmailPassword(email, password);
  }

  @override
  Future<void> signOut() async {
    return _firebaseHelper.signOut();
  }

  @override
  bool isUserLoggedIn() {
    return _firebaseHelper.isUserLoggedIn();
  }

  @override
  Future<void> saveUserToBackend(UserModel user) async {
    return _firebaseHelper.saveUserToBackend(user);
  }

  @override
  Future<UserModel> fetchUserFromBackend() async {
    return _firebaseHelper.fetchUserFromBackend();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    return _firebaseHelper.sendPasswordResetEmail(email);
  }
}