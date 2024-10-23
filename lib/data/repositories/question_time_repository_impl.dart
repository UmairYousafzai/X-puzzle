import 'package:flutter/foundation.dart';
import 'package:xpuzzle/data/dao/time_dao.dart';
import 'package:xpuzzle/data/models/local/question_model.dart';
import 'package:xpuzzle/domain/entities/question.dart';
import 'package:xpuzzle/domain/entities/time.dart';
import 'package:xpuzzle/domain/repositories/question_repository.dart';
import 'package:xpuzzle/domain/repositories/question_time_repository.dart';

import '../dao/question_dao.dart';
import '../data_source/local/database_helper.dart';
import '../models/local/question_time_model.dart';

class QuestionTimeRepositoryImpl extends QuestionTimeRepository {
  final TimeDao _timeDao;

  QuestionTimeRepositoryImpl(this._timeDao);

  @override
  Future<int> storeQuestionTime(QuestionTime questionTime) async {
    try {
      QuestionTimeModel questionTimeModel =
          QuestionTimeModel.copy(questionTime);
     return await _timeDao.insertQuestionTime(questionTimeModel);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return 0;
    }
  }

  @override
  Future<QuestionTime?> getQuestionTime(
      {bool isPPAndPS = false,
      bool isPPAndNS = false,
      bool isNPAndPS = false,
      bool isNPAndNS = false}) async {
    return await _timeDao.getQuestionTime(
        isPPAndPS: isPPAndPS,
        isPPAndNS: isPPAndNS,
        isNPAndPS: isNPAndPS,
        isNPAndNS: isNPAndNS);
  }
}
