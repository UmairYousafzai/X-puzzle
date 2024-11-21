import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/data/models/local/question_time_model.dart';
import 'package:xpuzzle/presentation/providers/question/question_provider.dart';
import 'package:xpuzzle/presentation/providers/question/question_state.dart';
import 'package:xpuzzle/presentation/providers/result_provider.dart';
import 'package:xpuzzle/presentation/providers/shared_pref_provider.dart';
import 'package:xpuzzle/presentation/screens/dialogs/show_on_question_complete_dialog.dart';
import 'package:xpuzzle/utils/constants.dart';
import 'package:xpuzzle/utils/navigation/navigate.dart';

import '../../../domain/entities/question.dart';
import '../../providers/game_provider.dart';
import '../../providers/level_provider.dart';
import '../../providers/question/question_usecase_provider.dart';
import '../../providers/time/time_use_case_provider.dart';
import '../../theme/colors.dart';
import '../../widgets/buttons/buttons.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/snackBar_messages.dart';
import '../quiz_completion_screen.dart';
import 'game_custom_progress_bar.dart';
import 'game_time_widget.dart';
import 'game_widget.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() {
    return _GameScreenState();
  }
}

class _GameScreenState extends ConsumerState<GameScreen> {
  int questionIndex = 0;

  @override
  void initState() {
    super.initState();

    Future(() {
      setGameState();
    });
  }

  void setGameState() {
    var questions = ref.read(questionProvider).questions;
    var index = 0;
    for (int i = 0; i < questions.length; i++) {
      if (!questions[i].isComplete) {
        index = i;
        break;
      }
    }
    var question = questions[index];
    var gameNotifier = ref.read(gameProvider.notifier);
    gameNotifier.updateQuestion(question);
    gameNotifier.updateQuestionIndex(index);
    getQuestionsTime(question, gameNotifier);
    questionIndex = ref.watch(gameProvider).questionIndex;
    getQuestionProgress(
        isPPAndPS: question.isPPAndPS,
        isPPAndNS: question.isPPAndNS,
        isNPAndPS: question.isNPAndPS,
        isNPAndNS: question.isNPAndNS);
  }

  void getQuestionProgress(
      {bool isPPAndPS = false,
      bool isPPAndNS = false,
      bool isNPAndPS = false,
      bool isNPAndNS = false}) async {
    ref.watch(sharedPreferencesProvider).when(
        data: (sharedPreference) {
          var progress = sharedPreference.getQuestionProgress(
              isPPAndPS: isPPAndPS,
              isPPAndNS: isPPAndNS,
              isNPAndPS: isNPAndPS,
              isNPAndNS: isNPAndNS);

          ref.read(gameProvider.notifier).setQuestionProgress(progress ?? 0);
        },
        error: (err, stack) {},
        loading: () {});
  }

  void getQuestionsTime(Question question, GameNotifier gameNotifier) async {
    var time = await ref.read(getTimeUseCaseProvider).execute(
        isNPAndNS: question.isNPAndNS,
        isNPAndPS: question.isNPAndPS,
        isPPAndNS: question.isPPAndNS,
        isPPAndPS: question.isPPAndPS);

    if (time != null) {
      if (kDebugMode) {
        print(
            "question time=============> ${QuestionTimeModel.copy(time).toJson()}");
      }

      gameNotifier.setTime(time.minutes, time.seconds, time.id);
    } else {
      if (kDebugMode) {
        print("question time=============> null");
      }
    }
  }

  double calculateCompletionPercentage(int progress) {
    double percentage = (progress / 10) * 100;

    percentage = percentage / 100;

    if (kDebugMode) {
      print("complete question percentage==============> $percentage");
    }
    return percentage;
  }

  void setProgressOfQuestions(
      {required int currentProgress,
      bool isPPAndPS = false,
      bool isPPAndNS = false,
      bool isNPAndPS = false,
      bool isNPAndNS = false}) async {
    ref.watch(sharedPreferencesProvider).when(
        data: (sharedPreference) {
          sharedPreference.saveQuestionProgress(
              value: currentProgress,
              isPPAndPS: isPPAndPS,
              isPPAndNS: isPPAndNS,
              isNPAndPS: isNPAndPS,
              isNPAndNS: isNPAndNS);
        },
        error: (err, stack) {
          if (kDebugMode) {
            print(err);
          }
        },
        loading: () {});
  }

  void onMarkDone(
      GameNotifier gameNotifier,
      GameState gameState,
      QuestionState questionState,
      QuestionProviderNotifier questionNotifier,
      bool shouldValidateData) async {
    if (validateQuestion(shouldValidateData)) {
      showOnQuestionCompleteDialog(
          isCorrectAnswer: isCorrectQuestion(gameState),
          context: context,
          onNext: () async {
            if (questionState.questions.length == 1)
              Navigator.pop(context);
            await updateQuestion(
                gameState, questionState, questionNotifier, gameNotifier);
            checkIfQuestionsCompleted(gameState, questionState, gameNotifier);
          },
          onTryAgain: () {
            gameNotifier.updateFirstNumber("");
            gameNotifier.updateSecondNumber("");
          },
          onClose: () {
            Navigator.pop(context);
          });
    }
  }

  void checkIfQuestionsCompleted(GameState gameState,
      QuestionState questionState, GameNotifier gameNotifier) {
    if (questionState.questions.isEmpty) {
      setQuestionTypeForResults(gameState);

      //setting status of the  style to pref
      ref.watch(sharedPreferencesProvider).when(
          data: (pref) {
            pref.setStyleStatus(
                value: true,
                isPPAndPS: gameState.question?.isPPAndPS ?? false,
                isPPAndNS: gameState.question?.isPPAndNS ?? false,
                isNPAndPS: gameState.question?.isNPAndPS ?? false,
                isNPAndNS: gameState.question?.isNPAndNS ?? false);
            ref.read(sharedPreferencesProvider.notifier).setUpdated(true);
            gameNotifier.resetGame();
            navigateToResult();
          },
          error: (err, stack) {
            if (kDebugMode) {
              print(err);
            }
          },
          loading: () {});
    }
  }

  void navigateToResult() {
    navigatePushAndRemoveUntil(context, const QuizCompletionScreen(), true);
  }

  void setQuestionTypeForResults(GameState gameState) {
    ref.read(resultProvider.notifier).setQuestionType(
        isPPAndPS: gameState.question?.isPPAndPS ?? false,
        isPPAndNS: gameState.question?.isPPAndNS ?? false,
        isNPAndPS: gameState.question?.isNPAndPS ?? false,
        isNPAndNS: gameState.question?.isNPAndNS ?? false);
  }

  Future<void> updateQuestion(
    GameState gameState,
    QuestionState questionState,
    QuestionProviderNotifier questionNotifier,
    GameNotifier gameNotifier,
  ) async {
    var isCorrect = isCorrectQuestion(gameState);

    var question = gameState.question;

    if (question != null) {
      questionNotifier.removeQuestion(question);

      question.isCorrect = isCorrect;
      question.isComplete = true;
      question.inputNumOne =
          gameState.firstNumber.isEmpty ? "0" : gameState.firstNumber;
      question.inputNumTwo =
          gameState.secondNumber.isEmpty ? "0" : gameState.secondNumber;
      await ref.watch(updateQuestionUseCaseProvider).execute(question);
    }

    gameNotifier.updateQuestionProgress();
    setProgressOfQuestions(
        currentProgress: gameState.questionProgress,
        isPPAndPS: gameState.question?.isPPAndPS ?? false,
        isPPAndNS: gameState.question?.isPPAndNS ?? false,
        isNPAndPS: gameState.question?.isNPAndPS ?? false,
        isNPAndNS: gameState.question?.isNPAndNS ?? false);
    if (questionState.questions.isNotEmpty) {
      gameNotifier
          .updateQuestion(ref.watch(questionProvider).questions[questionIndex]);
      if (kDebugMode) {
        print(
            "question index : $questionIndex==============>>>> questions length ${ref.read(questionProvider).questions.length}");
      }
    }
  }

  bool isCorrectQuestion(GameState gameState) {
    try {
      final question = gameState.question;
      final inputNumOne = gameState.firstNumber;
      final inputNumTwo = gameState.secondNumber;
      int product = int.parse(inputNumOne) * int.parse(inputNumTwo);
      int sum = int.parse(inputNumOne) + int.parse(inputNumTwo);

      return (product.toString() == question?.topNum) &&
          (sum.toString() == question?.bottomNum);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      return false;
    }
  }

  bool validateQuestion(bool shouldCheck) {
    var gameState = ref.watch(gameProvider);
    var gameNotifier = ref.watch(gameProvider.notifier);
    if (!shouldCheck) return true;
    if (!gameState.isTimerRunning) {
      showErrorSnackBar(context, "Please start the game.");
      return false;
    }
    var isFieldEmpty = false;
    if (gameState.firstNumber.isEmpty) {
      gameNotifier.setErrorOnInputOne(true);
      isFieldEmpty = true;
    }

    if (gameState.secondNumber.isEmpty) {
      gameNotifier.setErrorOnInputTwo(true);
      isFieldEmpty = true;
    }

    if (isFieldEmpty) {
      return false;
    }
    gameNotifier.setErrorOnInputTwo(false);
    gameNotifier.setErrorOnInputOne(false);

    return true;
  }

  void switchQuestion(QuestionState questionState, GameState gameState,
      GameNotifier gameNotifier) {
    ref.read(questionProvider.notifier).switchQuestion(gameState.questionIndex);
    gameNotifier
        .updateQuestion(questionState.questions[gameState.questionIndex]);
  }

  void completeAllRemainingQuestions(
      QuestionState questionState,
      GameNotifier gameNotifier,
      GameState gameState,
      QuestionProviderNotifier questionNotifier) {
    if (kDebugMode) {
      print("completeAllRemainingQuestions============  called");
    }

    var questions = questionState.questions;
    for (int i = 0; i < questions.length; i++) {
      updateQuestion(gameState, questionState, questionNotifier, gameNotifier);
      checkIfQuestionsCompleted(gameState, questionState, gameNotifier);
    }
  }

  @override
  Widget build(BuildContext context) {
    final questionsState = ref.watch(questionProvider);
    final questionsProvider = ref.watch(questionProvider.notifier);
    final gameState = ref.watch(gameProvider);
    final gameNotifier = ref.read(gameProvider.notifier);
    final level = ref.read(levelProvider);

    double screenPadding =
        MediaQuery.of(context).size.height > smallDeviceThreshold ? 10 : 5;

    ref.listen<GameState>(gameProvider, (prev, next) {
      if (next.isTimerFinished) {
        if (kDebugMode) {
          print("isTimerFinished  ${next.isTimerFinished}");
        }
        completeAllRemainingQuestions(
            questionsState, gameNotifier, gameState, questionsProvider);
      }
    });

    return PopScope(
      onPopInvoked: (canPop) {
        gameNotifier.resetGame();
      },
      child: Scaffold(
        backgroundColor: MColors().white,
        resizeToAvoidBottomInset: true,
        appBar: customAppBar(
            context,
            gameState.getLevel(), // Pass the current level here
            SvgPicture.asset(
              "assets/icons/svg/hamburger_menu_icon.svg",
              width: 40,
              height: 25,
            ),
            null,
            onPressedLeading: (buildContext) {

            },
            titleColor: const Color(0xFF1E2D7C)),
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                screenPadding, screenPadding, screenPadding, screenPadding),
            child: Column(
              children: [
                Gap(context.screenHeight * 0.02),
                Row(
                  children: [
                    GameTimeWidget(
                      time:
                          '${gameState.minutes.toString().padLeft(2, '0')}:${gameState.seconds.toString().padLeft(2, '0')}',
                    ),
                    const Spacer(),
                    gameState.isTimerRunning
                        ? Container()
                        : gameStartResetButton(context, () {
                            gameNotifier.playTimer(); // Button to start timer
                          }, 'assets/icons/svg/play_icon.svg',
                            MColors().colorPrimary),
                    Gap(MediaQuery.of(context).size.height >
                            smallDeviceThreshold
                        ? 20
                        : 10),
                    Opacity(
                      opacity: gameState.isTimerRunning ? 1.0 : 0.33,
                      child: gameStartResetButton(context, () {
                        if (gameState.isTimerRunning) {
                          switchQuestion(
                              questionsState, gameState, gameNotifier);
                        }
                      }, 'assets/icons/svg/reset_icon.svg',
                          MColors().colorSecondaryBlueDark),
                    ),
                  ],
                ),
                Gap(MediaQuery.of(context).size.height > smallDeviceThreshold
                    ? context.screenHeight * 0.03
                    : context.screenHeight * 0.02),
                CustomProgressBar(
                  progress:
                      calculateCompletionPercentage(gameState.questionProgress),
                ),
                Gap(MediaQuery.of(context).size.height > smallDeviceThreshold
                    ? context.screenHeight * 0.07
                    : context.screenHeight * 0.1),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GameWidget(onMarkDonePressed: () {
                      onMarkDone(gameNotifier, gameState, questionsState,
                          questionsProvider, true);
                    }),
                    Gap(MediaQuery.of(context).size.height >
                            smallDeviceThreshold
                        ? context.screenHeight * 0.09
                        : context.screenHeight * 0.1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        gameBacknNextButton(context, () {
                          Navigator.pop(context);
                          // if (questionIndex >= 0) {
                          //   if (mounted) {
                          //     questionIndex--;
                          //     if (!questions
                          //         .questions[questionIndex].isComplete) {
                          //       gameNotifier.updateQuestion(
                          //           questions.questions[questionIndex]);
                          //     }
                          //   }
                          // } else {
                          //   Navigator.pop(context);
                          // }
                        }, false, !gameState.isTimerRunning), // Back button
                        Gap(MediaQuery.of(context).size.height >
                                smallDeviceThreshold
                            ? 50
                            : 25),
                        gameBacknNextButton(context, () {
                          onMarkDone(gameNotifier, gameState, questionsState,
                              questionsProvider, true);
                          // if (questionIndex <= questions.questions.length - 1) {
                          //   if (mounted) {
                          //     questionIndex++;
                          //
                          //     gameNotifier.updateQuestion(
                          //         questions.questions[questionIndex]);
                          //   }
                          // }
                        }, true, true), // Next Button
                      ],
                    ),
                    Gap(context.screenHeight * 0.01)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
