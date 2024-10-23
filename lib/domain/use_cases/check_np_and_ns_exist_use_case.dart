import 'package:xpuzzle/domain/repositories/question_repository.dart';
import 'package:xpuzzle/domain/entities/question.dart';

class CheckNpAndNsExist {
  final QuestionRepository questionRepository;

  CheckNpAndNsExist(this.questionRepository);

  Future<bool> execute() async {
    return await questionRepository.checkIfIsNPAndNSExists();
  }
}
