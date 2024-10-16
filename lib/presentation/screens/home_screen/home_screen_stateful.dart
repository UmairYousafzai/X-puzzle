import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xpuzzle/data/data_source/local/question_generator.dart';
import 'package:xpuzzle/domain/entities/question.dart';
import 'package:xpuzzle/domain/repositories/question_repository.dart';
import 'package:xpuzzle/domain/use_cases/get_questions.dart';
import 'package:xpuzzle/domain/use_cases/store_questions.dart';
import 'package:xpuzzle/presentation/providers/question/question_provider.dart';
import 'package:xpuzzle/presentation/providers/question/question_repository_provider.dart';
import 'package:xpuzzle/presentation/widgets/snackBar_messages.dart';
import '../../providers/home_screen_providers.dart';
import '../../providers/question/question_usecase_provider.dart';
import '../game_screen/game_screen.dart';
import 'home_screen_card_design.dart';

class HomeScreenConsumerWidget extends ConsumerStatefulWidget {
  const HomeScreenConsumerWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return HomeScreenConsumerState();
  }
}

class HomeScreenConsumerState extends ConsumerState<HomeScreenConsumerWidget> {
  Future<void> generateAndStoreQuestion({
    required GetQuestions getQuestions,
    required StoreQuestions storeQuestions,
    required QuestionProviderNotifier questionNotifier,
    bool isPPAndPS = false,
    bool isPPAndNS = false,
    bool isNPAndPS = false,
    bool isNPAndNS = false,
  }) async {
    List<Question> questions =
        generatePositiveMultipleAndPositiveInteger(numberOfQuestion: 10);

    await storeQuestions.execute(questions);
    if (questions.isNotEmpty) {
      var storeQuestions = await getQuestions.execute(
          isPPAndPS: isPPAndPS,
          isPPAndNS: isPPAndNS,
          isNPAndPS: isNPAndPS,
          isNPAndNS: isNPAndNS);
      questionNotifier.addQuestion(
          questions: storeQuestions,
          isPPAndPS: isPPAndPS,
          isPPAndNS: isPPAndNS,
          isNPAndPS: isNPAndPS,
          isNPAndNS: isNPAndNS);
    }
  }

  Future<List<Question>> getQuestions(
    GetQuestions getQuestion,
    QuestionProviderNotifier questionNotifier, {
    bool isPPAndPS = false,
    bool isPPAndNS = false,
    bool isNPAndPS = false,
    bool isNPAndNS = false,
  }) async {
    var questions = await getQuestion.execute(
        isPPAndPS: isPPAndPS,
        isPPAndNS: isPPAndNS,
        isNPAndPS: isNPAndPS,
        isNPAndNS: isNPAndNS);

    if (questions.isNotEmpty) {
      questionNotifier.addQuestion(
          questions: questions,
          isPPAndPS: isPPAndPS,
          isPPAndNS: isPPAndNS,
          isNPAndPS: isNPAndPS,
          isNPAndNS: isNPAndNS);
    }

    return questions;
  }

  bool isQuestionsCompleted(List<Question> questions) {
    if (questions.isNotEmpty) {
      for (final question in questions) {
        if (!question.isComplete) {
          return false;
        }
      }
    } else {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final storeQuestionsUseCase = ref.watch(storeQuestionUseCaseProvider);
    final isPPAndPSQuestionUseCase = ref.watch(isPPAndPSUseCaseProvider);
    final getQuestionUseCase = ref.watch(getQuestionUseCaseProvider);
    var questionNotifier = ref.read(questionProvider.notifier);
    final navigator = Navigator.of(context);
    final cards = ref.watch(homeScreenStylesProvider);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemCount: cards.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            GestureDetector(
                onTap: () async {
                  var questions = await getQuestions(
                      getQuestionUseCase, questionNotifier,
                      isPPAndPS: index == 0,
                      isPPAndNS: index == 1,
                      isNPAndPS: index == 2,
                      isNPAndNS: index == 3);
                  var isQuestionsExist =
                      await isPPAndPSQuestionUseCase.execute();
                  if (isQuestionsExist && questions.isEmpty) {
                    showErrorSnackBar(context, "This style already attempted.");
                  } else {
                    if (questions.isEmpty) {
                      generateAndStoreQuestion(
                          getQuestions: getQuestionUseCase,
                          storeQuestions: storeQuestionsUseCase,
                          questionNotifier: questionNotifier,
                          isPPAndPS: index == 0,
                          isPPAndNS: index == 1,
                          isNPAndPS: index == 2,
                          isNPAndNS: index == 3);
                    }
                    navigator.push(MaterialPageRoute(
                        builder: (ctx) => const GameScreen()));
                  }
                },
                child: StyleCard(styleItemModel: cards[index])),
          ],
        );
      },
    );
  }
}
