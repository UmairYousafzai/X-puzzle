import 'package:xpuzzle/domain/repositories/question_repository.dart';
import 'package:xpuzzle/domain/entities/question.dart';

class CheckIsPpAndPsExist {
  final QuestionRepository questionRepository;

  CheckIsPpAndPsExist(this.questionRepository);

  Future<bool> execute() async {
    return await questionRepository.checkIfIsPPAndPSExists();
  }
}
