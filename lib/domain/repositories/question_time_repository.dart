import 'package:xpuzzle/domain/entities/time.dart';


abstract class QuestionTimeRepository {
  Future<int> storeQuestionTime(QuestionTime questionTime);

  Future<QuestionTime?> getQuestionTime({
    bool isPPAndPS = false,
    bool isPPAndNS = false,
    bool isNPAndPS = false,
    bool isNPAndNS = false,
  });
}
