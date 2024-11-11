import 'package:xpuzzle/domain/entities/question.dart';
import 'package:xpuzzle/domain/repositories/question_repository.dart';
import 'package:xpuzzle/domain/repositories/question_time_repository.dart';

class DeleteQuestionsTime {
  final QuestionTimeRepository questionTimeRepository;

  DeleteQuestionsTime(this.questionTimeRepository);

  Future<void> execute({
    bool isPPAndPS = false,
    bool isPPAndNS = false,
    bool isNPAndPS = false,
    bool isNPAndNS = false,
  }) async {
    await questionTimeRepository.deleteQuestionTime(
      isPPAndPS: isPPAndPS,
      isPPAndNS: isPPAndNS,
      isNPAndPS: isNPAndPS,
      isNPAndNS: isNPAndNS,
    );
  }
}
