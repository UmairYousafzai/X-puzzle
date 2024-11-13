import 'package:xpuzzle/domain/entities/question.dart';
import 'package:xpuzzle/domain/repositories/question_repository.dart';

class DeleteQuestions {
  final QuestionRepository questionRepository;

  DeleteQuestions(this.questionRepository);

  Future<void> execute({
    bool isPPAndPS = false,
    bool isPPAndNS = false,
    bool isNPAndPS = false,
    bool isNPAndNS = false,
  }) async {
    await questionRepository.deleteQuestions(
      isPPAndPS: isPPAndPS,
      isPPAndNS: isPPAndNS,
      isNPAndPS: isNPAndPS,
      isNPAndNS: isNPAndNS,
    );
  }
}
