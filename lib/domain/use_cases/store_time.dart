import 'package:xpuzzle/domain/entities/time.dart';
import 'package:xpuzzle/domain/repositories/question_time_repository.dart';

class StoreTime {
  final QuestionTimeRepository questionTimeRepository;

  StoreTime(this.questionTimeRepository);

  Future<int> execute(QuestionTime questionTime) async {
   return await questionTimeRepository.storeQuestionTime(questionTime);
  }
}
