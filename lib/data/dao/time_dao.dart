import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xpuzzle/data/models/local/question_time_model.dart';
import '../data_source/local/database_helper.dart';

class TimeDao {
  final DatabaseHelper _databaseHelper;

  TimeDao(this._databaseHelper);

  Future<QuestionTimeModel?> getQuestionTime({
    bool isPPAndPS = false,
    bool isPPAndNS = false,
    bool isNPAndPS = false,
    bool isNPAndNS = false,
  }) async {
    try {
      final db = await _databaseHelper.database;
      final result = await db?.query(DatabaseHelper.TABLE_QUESTION_TIME,
          where:
              'is_pp_and_ps=? AND is_pp_and_ns=? AND is_np_and_ns=? AND is_np_and_ps=?',
          whereArgs: [
            isPPAndPS ? 1 : 0,
            isPPAndNS ? 1 : 0,
            isNPAndNS ? 1 : 0,
            isNPAndPS ? 1 : 0,
          ]);
      if (kDebugMode) {
        print("saves time values==============> ${result.toString()}");
      }

      if (result != null && result.isNotEmpty) {
        return QuestionTimeModel.fromJson(result.first);
      }

      return null;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<int> insertQuestionTime(QuestionTimeModel questionTime) async {
    if (kDebugMode) {
      print("saves time values==============> ${questionTime.toJson()}");
    }
    try {
      final db = await _databaseHelper.database;
      var id = await db?.insert(
        DatabaseHelper.TABLE_QUESTION_TIME,
        questionTime.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id ?? 0;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return 0;
    }
  }

  Future<void> deleteEntry({
    bool isPPAndPS = false,
    bool isPPAndNS = false,
    bool isNPAndPS = false,
    bool isNPAndNS = false,
    bool isComplete = true,
  }) async {
    final db = await _databaseHelper.database;

    await db?.delete(
      DatabaseHelper.TABLE_QUESTION_TIME,
      where:
          'is_pp_and_ps=? AND is_pp_and_ns=? AND is_np_and_ns=? AND is_np_and_ps=?',
      whereArgs: [
        isPPAndPS ? 1 : 0,
        isPPAndNS ? 1 : 0,
        isNPAndNS ? 1 : 0,
        isNPAndPS ? 1 : 0,
      ],
    );
  }
}
