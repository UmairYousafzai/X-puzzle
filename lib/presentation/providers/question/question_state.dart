import '../../../domain/entities/question.dart';

class QuestionState {
  final List<Question> questions;
  final bool isPPAndPS;

  final bool isPPAndNS;

  final bool isNPAndPS;

  final bool isNPAndNS;

  QuestionState({
    this.questions = const [],
    this.isPPAndNS = false,
    this.isNPAndNS = false,
    this.isNPAndPS = false,
    this.isPPAndPS = false,
  });

  QuestionState copyWith(
      {List<Question> questions = const [],
      bool isPPAndPS = false,
      bool isPPAndNS = false,
      bool isNPAndPS = false,
      bool isNPAndNS = false}) {
    return QuestionState(
      questions: questions ?? this.questions,
      isNPAndPS: isNPAndPS ?? this.isNPAndPS,
      isPPAndPS: isPPAndPS ?? this.isPPAndPS,
      isNPAndNS: isNPAndNS ?? this.isNPAndNS,
      isPPAndNS: isPPAndNS,
    );
  }
}
