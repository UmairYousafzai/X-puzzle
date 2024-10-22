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
import 'package:xpuzzle/utils/constants.dart';
import '../../providers/home_screen_providers.dart';
import '../../providers/question/question_usecase_provider.dart';
import '../../theme/colors.dart';
import '../game_screen/game_screen.dart';
import 'home_screen_grid_card.dart';

class HomeScreenGridView extends ConsumerStatefulWidget {
  const HomeScreenGridView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return HomeScreenGridViewState();
  }
}

class HomeScreenGridViewState extends ConsumerState<HomeScreenGridView> {
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
    final isNPAndNSQuestionUseCase = ref.watch(isNPAndNSUseCaseProvider);
    final getQuestionUseCase = ref.watch(getQuestionUseCaseProvider);
    var questionNotifier = ref.read(questionProvider.notifier);
    final navigator = Navigator.of(context);
    final ctxt= context;
    final cards = ref.watch(homeScreenStylesProvider);
    double childAspectRatio = context.screenWidth / (context.screenHeight * 0.64); // Adjust the multiplier to tweak the ratio

    return screenState["is_loading"]
        ? Center(
            child: CircularProgressIndicator(
              color: MColors().colorSecondaryBlueLight,
            ),
          )
        : GridView.builder(
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: cards.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  GestureDetector(
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
                      child: GridStyleCard(styleItemModel: cards[index])),
                ],
              );
            },
          );
  }
}
