import 'package:xpuzzle/domain/entities/time.dart';
import 'package:xpuzzle/domain/repositories/question_time_repository.dart';

class GetTimeByType {
  final QuestionTimeRepository questionTimeRepository;

  GetTimeByType(this.questionTimeRepository);

  Future<List<QuestionTime>?> execute(
      {bool isPPAndPS = false,
      bool isPPAndNS = false,
      bool isNPAndPS = false,
      bool isNPAndNS = false}) async {
    return await questionTimeRepository.getQuestionTimeByType(
        isPPAndPS: isPPAndPS,
        isPPAndNS: isPPAndNS,
        isNPAndPS: isNPAndPS,
        isNPAndNS: isNPAndNS);
  }
}
