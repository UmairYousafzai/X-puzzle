import 'package:xpuzzle/domain/entities/time.dart';
import 'package:xpuzzle/domain/repositories/question_time_repository.dart';

class GetTime {
  final QuestionTimeRepository questionTimeRepository;

  GetTime(this.questionTimeRepository);

  Future<QuestionTime?> execute(
      {bool isPPAndPS = false,
      bool isPPAndNS = false,
      bool isNPAndPS = false,
      bool isNPAndNS = false}) async {
    return await questionTimeRepository.getQuestionTime(
        isPPAndPS: isPPAndPS,
        isPPAndNS: isPPAndNS,
        isNPAndPS: isNPAndPS,
        isNPAndNS: isNPAndNS);
  }
}
