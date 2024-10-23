import 'package:xpuzzle/domain/repositories/question_repository.dart';
import 'package:xpuzzle/domain/entities/question.dart';

class CheckNpAndPsExist {
  final QuestionRepository questionRepository;

  CheckNpAndPsExist(this.questionRepository);

  Future<bool> execute() async {
    return await questionRepository.checkIfIsNPAndPSExists();
  }
}
