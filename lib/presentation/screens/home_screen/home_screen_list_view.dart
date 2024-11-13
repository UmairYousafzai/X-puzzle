import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../../data/data_source/local/question_generator.dart';
import '../../../domain/entities/question.dart';
import '../../../domain/use_cases/get_questions.dart';
import '../../../domain/use_cases/store_questions.dart';
import '../../providers/home_screen_providers.dart';
import '../../providers/question/question_provider.dart';
import '../../providers/question/question_usecase_provider.dart';
import '../../widgets/snackBar_messages.dart';
import '../game_screen/game_screen.dart';
import 'home_screen_list_card.dart';
import 'home_screen_grid_card.dart';

class HomeScreenListView extends ConsumerStatefulWidget {
  const HomeScreenListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return HomeScreenListViewState();
  }
}

class HomeScreenListViewState extends ConsumerState<HomeScreenListView> {
  Future<void> generateAndStoreQuestion({
    required GetQuestions getQuestionsUseCase,
    required StoreQuestions storeQuestions,
    required QuestionProviderNotifier questionNotifier,
    bool isPPAndPS = false,
    bool isPPAndNS = false,
    bool isNPAndPS = false,
    bool isNPAndNS = false,
  }) async {
    List<Question> questions = generatePositiveMultipleAndPositiveInteger(
        numberOfQuestion: 10,
        isPPAndPS: isPPAndPS,
        isPPAndNS: isPPAndNS,
        isNPAndPS: isNPAndPS,
        isNPAndNS: isNPAndNS);

    await storeQuestions.execute(questions);
    if (questions.isNotEmpty) {
      await getQuestions(getQuestionsUseCase, questionNotifier,
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

    await Future.delayed(const Duration(milliseconds: 1000));
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
    final screenState = ref.watch(homeViewTypeProvider);
    final screenStateNotifier = ref.watch(homeViewTypeProvider.notifier);
    final storeQuestionsUseCase = ref.watch(storeQuestionUseCaseProvider);
    final isPPAndPSQuestionUseCase = ref.watch(isPPAndPSUseCaseProvider);
    final isPPAndNSQuestionUseCase = ref.watch(isPPAndNSUseCaseProvider);
    final isNPAndPSQuestionUseCase = ref.watch(isNPAndPSUseCaseProvider);
    final isNPAndNSQuestionUseCase = ref.watch(isNPAndPSUseCaseProvider);
    final getQuestionUseCase = ref.watch(getQuestionUseCaseProvider);
    var questionNotifier = ref.read(questionProvider.notifier);
    final navigator = Navigator.of(context);
    final ctxt= context;
    final cards = ref.watch(homeScreenStylesProvider);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.715,
      child: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () async {
              screenStateNotifier.setLoading(true);
              var questions = await getQuestions(
                  getQuestionUseCase, questionNotifier,
                  isPPAndPS: index == 0,
                  isPPAndNS: index == 1,
                  isNPAndPS: index == 2,
                  isNPAndNS: index == 3);
              var isQuestionsExist = false;
              if (index == 0) {
                isQuestionsExist =
                    await isPPAndPSQuestionUseCase.execute();
              } else if (index == 1) {
                isQuestionsExist =
                    await isPPAndNSQuestionUseCase.execute();
              } else if (index == 2) {
                isQuestionsExist =
                    await isNPAndPSQuestionUseCase.execute();
              } else if (index == 3) {
                isQuestionsExist =
                    await isNPAndNSQuestionUseCase.execute();
              }
              if (isQuestionsExist && questions.isEmpty) {
                screenStateNotifier.setLoading(false);
                showErrorSnackBar(
                    ctxt, "This style already attempted.");
              } else {
                if (questions.isEmpty) {
                  await generateAndStoreQuestion(
                  getQuestionsUseCase: getQuestionUseCase,
                  storeQuestions: storeQuestionsUseCase,
                  questionNotifier: questionNotifier,
                  isPPAndPS: index == 0,
                  isPPAndNS: index == 1,
                  isNPAndPS: index == 2,
                  isNPAndNS: index == 3);
                }
                screenStateNotifier.setLoading(false);
                navigator.push(MaterialPageRoute(
                    builder: (ctx) => const GameScreen()));
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListStyleCard(item: cards[index]),
            ),
          );
        },
      ),
    );
  }
}
