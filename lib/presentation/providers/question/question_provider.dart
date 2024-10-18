import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xpuzzle/domain/entities/question.dart';
import 'package:xpuzzle/domain/use_cases/get_questions.dart';
import 'package:xpuzzle/presentation/providers/question/question_state.dart';
import 'package:xpuzzle/presentation/providers/question/question_usecase_provider.dart';

class QuestionProviderNotifier extends StateNotifier<QuestionState> {
  final GetQuestions getQuestionsUseCase;

  QuestionProviderNotifier(this.getQuestionsUseCase) : super(QuestionState());

  void addQuestion(
      {List<Question> questions = const [],
      bool isPPAndPS = false,
      bool isPPAndNS = false,
      bool isNPAndPS = false,
      bool isNPAndNS = false}) {
    state = state.copyWith(
        questions: questions,
        isPPAndPS: isPPAndPS,
        isPPAndNS: isPPAndNS,
        isNPAndPS: isNPAndPS,
        isNPAndNS: isNPAndNS);
  }

  Future<void> reFetchQuestion() async {
    var newQuestions = await getQuestionsUseCase.execute(
        isPPAndPS: state.isPPAndPS,
        isPPAndNS: state.isPPAndNS,
        isNPAndPS: state.isNPAndPS,
        isNPAndNS: state.isNPAndNS);

    state = state.copyWith(questions: newQuestions);
  }

  Future<void> fetchQuestion(
      {bool isPPAndPS = false,
      bool isPPAndNS = false,
      bool isNPAndPS = false,
      bool isNPAndNS = false}) async {
    var newQuestions = await getQuestionsUseCase.execute(
        isPPAndPS: isPPAndPS,
        isPPAndNS: isPPAndNS,
        isNPAndPS: isNPAndPS,
        isNPAndNS: isNPAndNS,
        isComplete: true);

    state = state.copyWith(
        questions: newQuestions,
        isPPAndPS: isPPAndPS,
        isPPAndNS: isPPAndNS,
        isNPAndPS: isNPAndPS,
        isNPAndNS: isNPAndNS);
  }

  void removeQuestion(Question question) {
    var questions = state.questions;
    questions.remove(question);
    state = state.copyWith(questions: questions);
  }

  void switchQuestion(int index) {
    var questions = state.questions;
    var questionToReplace = questions[index];

    if (kDebugMode) {
      print(
          "current index: $index ============= quetions length ${questions.length}");
    }
    var newIndex = 0;
    if (index <= 1) {
      newIndex = Random().nextInt(5);
      newIndex = (questions.length - 1) - newIndex;
    } else {
      newIndex = Random().nextInt(index == 0 ? index + 1 : index) +
          (questions.length - index);
    }
    var questionWhichReplace = questions[newIndex];
    questions[index] = questionWhichReplace;
    questions[newIndex] = questionToReplace;

    state = state.copyWith(questions: questions);

    if (kDebugMode) {
      print("current index: $index ============= new index$newIndex");
    }
  }
}

final questionProvider =
    StateNotifierProvider<QuestionProviderNotifier, QuestionState>((ref) {
  return QuestionProviderNotifier(ref.read(getQuestionUseCaseProvider));
});
