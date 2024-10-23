import 'package:xpuzzle/domain/repositories/question_repository.dart';
import 'package:xpuzzle/domain/entities/question.dart';

class StoreQuestions {
  final QuestionRepository questionRepository;

  StoreQuestions(this.questionRepository);

  Future<void> execute(List<Question> questions) async {
    await questionRepository.storeQuestions(questions);
  }
}
