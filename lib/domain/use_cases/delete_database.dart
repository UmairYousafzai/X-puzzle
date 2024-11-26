import 'package:xpuzzle/domain/entities/question.dart';
import 'package:xpuzzle/domain/repositories/question_repository.dart';

class DeleteDatabase {
  final QuestionRepository questionRepository;

  DeleteDatabase(this.questionRepository);

  Future<bool> execute() async {
    return await questionRepository.deleteDatabase();
  }
}
