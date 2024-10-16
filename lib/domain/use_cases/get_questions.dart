import 'package:xpuzzle/domain/repositories/question_repository.dart';
import 'package:xpuzzle/domain/entities/question.dart';

class GetQuestions {
  final QuestionRepository questionRepository;

  GetQuestions(this.questionRepository);

  Future<List<Question>> execute(
      {bool isPPAndPS = false,
      bool isPPAndNS = false,
      bool isNPAndPS = false,
      bool isNPAndNS = false}) async {
    return await questionRepository.getQuestion(
        isPPAndPS: isPPAndPS,
        isPPAndNS: isPPAndNS,
        isNPAndPS: isNPAndPS,
        isNPAndNS: isNPAndNS);
  }
}
