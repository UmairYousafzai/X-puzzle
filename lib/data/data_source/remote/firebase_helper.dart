// firebase_helper.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../models/local/user_model.dart';

class FirebaseHelper {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  FirebaseHelper(this._firebaseAuth, this._firestore);

  Future<void> signUpWithEmailPassword(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Error in signUpWithEmailPassword: ${e.message}");
      }
      rethrow; // Re-throw the error to handle it in the notifier
    }
  }

  Future<void> signInWithEmailPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Error in signInWithEmailPassword: ${e.message}");
      }
      rethrow; // Re-throw the error to handle it in the notifier
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Error in signOut: ${e.toString()}");
      }
      rethrow; // Re-throw the error to handle it in the notifier
    }
  }

  bool isUserLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }

  Future<void> saveUserToBackend(UserModel user) async {
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) throw Exception("No authenticated user found");
    await _firestore.collection("users").doc(userId).set(user.toJson());
  }

  Future<UserModel> fetchUserFromBackend() async {
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) throw Exception("No authenticated user found");
    final doc = await _firestore.collection("users").doc(userId).get();
    if (!doc.exists) throw Exception("User not found");
    return UserModel.fromJson(doc.data()!);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Error in sendPasswordResetEmail: ${e.message}");
      }
      rethrow;
    }
  }
}