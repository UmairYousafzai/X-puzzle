import 'package:xpuzzle/domain/repositories/question_repository.dart';
import 'package:xpuzzle/domain/entities/question.dart';

class CheckPpAndNsExist {
  final QuestionRepository questionRepository;

  CheckPpAndNsExist(this.questionRepository);

  Future<bool> execute() async {
    return await questionRepository.checkIfIsPPAndNSExists();
  }
}
