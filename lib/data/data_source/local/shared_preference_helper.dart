import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/entities/user.dart';

class SharedPreferencesHelper {
  final SharedPreferences _sharedPreferences;
  final String LEVEL_KEY = "level";
  final String STYLE_KEY = "style";
  final String QUESTION_PROGRESS_KEY = "question_progress";
  final String SWITCH_INDICES_KEY = "indices";
  final String USER_DETAILS_KEY = "userDetails";
  final bool isUpdated;

  SharedPreferencesHelper(this._sharedPreferences,this.isUpdated);

  Future<void> saveString(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }

  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  Future<void> saveBool(String key, bool value) async {
    await _sharedPreferences.setBool(key, value);
  }

  bool? getBool(String key) {
    return _sharedPreferences.getBool(key);
  }

  Future<void> clear() async {
    await _sharedPreferences.clear();
  }

  Future<void> remove(String key) async {
    await _sharedPreferences.remove(key);
  }

  Future<void> saveUser(User user) async {
    final userJson = jsonEncode(user.toJson());
    await _sharedPreferences.setString(USER_DETAILS_KEY, userJson);
  }

  User? getUser() {
    final userJson = _sharedPreferences.getString(USER_DETAILS_KEY);
    if (userJson != null) {
      final Map<String, dynamic> json = jsonDecode(userJson);
      return User.fromJson(json);
    }
    return null;
  }

  Future<void> saveLevel(String level) async {
    if (kDebugMode) {
      print("level saved value==============> $level");
    }
    await _sharedPreferences.setString(LEVEL_KEY, level);
  }

  String? getLevel() {
    return _sharedPreferences.getString(LEVEL_KEY);
  }

  Future<void> setStyleStatus(
      {bool isPPAndPS = false,
      bool isPPAndNS = false,
      bool isNPAndPS = false,
      bool isNPAndNS = false, required bool value ,}) async {
    String keyPrefix = "";

    if (isPPAndPS) {
      keyPrefix = "isPPAndPS";
    } else if (isPPAndNS) {
      keyPrefix = "isPPAndNS";
    } else if (isNPAndPS) {
      keyPrefix = "isNPAndPS";
    } else if (isNPAndNS) {
      keyPrefix = "isNPAndNS";
    }

    if (kDebugMode) {
      print("style saved value==============> $keyPrefix");
    }
    await _sharedPreferences.setBool("$keyPrefix-$STYLE_KEY", value);
  }

  bool? isStyleAttempted(  {bool isPPAndPS = false,
    bool isPPAndNS = false,
    bool isNPAndPS = false,
    bool isNPAndNS = false}) {
    String keyPrefix = "";

    if (isPPAndPS) {
      keyPrefix = "isPPAndPS";
    } else if (isPPAndNS) {
      keyPrefix = "isPPAndNS";
    } else if (isNPAndPS) {
      keyPrefix = "isNPAndPS";
    } else if (isNPAndNS) {
      keyPrefix = "isNPAndNS";
    }

    if (kDebugMode) {
      print("style get value==============> $keyPrefix");
    }
    return _sharedPreferences.getBool("$keyPrefix-$STYLE_KEY");
  }

  Future<void> saveQuestionProgress(
      {required int value,
      bool isPPAndPS = false,
      bool isPPAndNS = false,
      bool isNPAndPS = false,
      bool isNPAndNS = false}) async {
    String keyPrefix = "";

    if (kDebugMode) {
      print("saveQuestionProgress==============> $value");
    }
    if (isPPAndPS) {
      keyPrefix = "isPPAndPS";
    } else if (isPPAndNS) {
      keyPrefix = "isPPAndNS";
    } else if (isNPAndPS) {
      keyPrefix = "isNPAndPS";
    } else if (isNPAndNS) {
      keyPrefix = "isNPAndNS";
    }
    await _sharedPreferences.setInt("$keyPrefix-$QUESTION_PROGRESS_KEY", value);
  }

  int? getQuestionProgress({
    bool isPPAndPS = false,
    bool isPPAndNS = false,
    bool isNPAndPS = false,
    bool isNPAndNS = false,
  }) {
    String keyPrefix = "";

    if (isPPAndPS) {
      keyPrefix = "isPPAndPS";
    } else if (isPPAndNS) {
      keyPrefix = "isPPAndNS";
    } else if (isNPAndPS) {
      keyPrefix = "isNPAndPS";
    } else if (isNPAndNS) {
      keyPrefix = "isNPAndNS";
    }
    return _sharedPreferences.getInt("$keyPrefix-$QUESTION_PROGRESS_KEY");
  }

  Future<void> savePreviousShuffle(Set<List<dynamic>> switchedIndices) async {
    var json = jsonEncode(switchedIndices);
    if (kDebugMode) {
      print("Set<int> switchedIndices value==============> $json");
    }
    await _sharedPreferences.setString(SWITCH_INDICES_KEY, json);
  }

  Set<List<dynamic>>? getPreviousShuffle() {
    var json = _sharedPreferences.getString(SWITCH_INDICES_KEY);
    if (json != null) {
      return jsonDecode(json) as Set<List<dynamic>>;
    } else {
      return null;
    }
  }
}
