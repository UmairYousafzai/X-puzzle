import '../entities/question.dart';

abstract class QuestionRepository {
  Future<void> storeQuestions(List<Question> questions);
  Future<void> updateQuestion(Question question);
  Future<bool> checkIfIsPPAndPSExists();
  Future<bool> checkIfIsPPAndNSExists();

  Future<List<Question>> getQuestion({
    bool isPPAndPS = false,
    bool isPPAndNS = false,
    bool isNPAndPS = false,
    bool isNPAndNS = false,
  });
}
