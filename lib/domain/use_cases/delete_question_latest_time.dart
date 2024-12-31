import 'package:xpuzzle/domain/entities/question.dart';
import 'package:xpuzzle/domain/repositories/question_repository.dart';
import 'package:xpuzzle/domain/repositories/question_time_repository.dart';

class DeleteQuestionsLatestTime {
  final QuestionTimeRepository questionTimeRepository;

  DeleteQuestionsLatestTime(this.questionTimeRepository);

  Future<void> execute({
    bool isPPAndPS = false,
    bool isPPAndNS = false,
    bool isNPAndPS = false,
    bool isNPAndNS = false,
  }) async {
    await questionTimeRepository.deleteQuestionLatestTime(
      isPPAndPS: isPPAndPS,
      isPPAndNS: isPPAndNS,
      isNPAndPS: isNPAndPS,
      isNPAndNS: isNPAndNS,
    );
  }
}
