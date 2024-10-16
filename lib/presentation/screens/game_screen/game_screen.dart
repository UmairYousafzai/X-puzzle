import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/data/models/local/question_time_model.dart';
import 'package:xpuzzle/presentation/providers/question/question_provider.dart';
import 'package:xpuzzle/presentation/providers/question/question_state.dart';
import 'package:xpuzzle/presentation/providers/shared_pref_provider.dart';
import 'package:xpuzzle/utils/constants.dart';

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
        error: (err, stack) {},
        loading: () {});
  }

  void onMarkDone(GameNotifier gameNotifier, GameState gameState) async {
    if (gameState.isTimerRunning) {
      if (gameState.firstNumber.isNotEmpty &&
          gameState.secondNumber.isNotEmpty) {
        var isCorrect = (gameState.firstNumber == gameState.question?.numOne ||
                gameState.firstNumber == gameState.question?.numTwo) &&
            (gameState.secondNumber == gameState.question?.numOne ||
                gameState.secondNumber == gameState.question?.numTwo);

        var question = gameState.question;

        if (question != null) {
          ref.watch(questionProvider.notifier).removeQuestion(question);

          question.isCorrect = isCorrect;
          question.isComplete = true;
          await ref.watch(updateQuestionUseCaseProvider).execute(question);
        }

        gameNotifier.updateQuestionProgress();
        setProgressOfQuestions(
            currentProgress: gameState.questionProgress,
            isPPAndPS: gameState.question?.isPPAndPS ?? false,
            isPPAndNS: gameState.question?.isPPAndNS ?? false,
            isNPAndPS: gameState.question?.isNPAndPS ?? false,
            isNPAndNS: gameState.question?.isNPAndNS ?? false);
        gameNotifier.updateQuestion(
            ref.watch(questionProvider).questions[questionIndex]);

        if (kDebugMode) {
          print(
              "question index : $questionIndex==============>>>> questions length ${ref.read(questionProvider).questions.length}");
        }
        if (ref.read(questionProvider).questions.isEmpty) {
          ref.read(gameProvider.notifier).resetGame();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const QuizCompletionScreen()),
            (Route<dynamic> route) {
              if (kDebugMode) {
                print("route name ${route.settings.name}");
              }
              return route.isFirst;
            },
          );
        }
      } else {
        showErrorSnackBar(context, "Please enter the answer.");
      }
    } else {
      showErrorSnackBar(context, "Please start the game.");
    }
  }

  void switchQuestion(QuestionState questionState, GameState gameState,
      GameNotifier gameNotifier) {
    ref.read(questionProvider.notifier).switchQuestion(gameState.questionIndex);
    gameNotifier
        .updateQuestion(questionState.questions[gameState.questionIndex]);
  }

  @override
  Widget build(BuildContext context) {
    final questions = ref.watch(questionProvider);
    final gameState = ref.watch(gameProvider);
    final gameNotifier = ref.read(gameProvider.notifier);
    final level = ref.read(levelProvider);

    return PopScope(
      onPopInvoked: (canPop) {
        gameNotifier.resetGame();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: level.when(
          data: (level) {
            return customAppBar(
              context,
              level, // Pass the current level here
              Image.asset(
                "assets/icons/drawer_icon.png",
                width: 50,
                height: 40,
              ),
              () {},
            );
          },
          loading: () => AppBar(
            title: const Text('Loading...'), // Temporary AppBar while loading
          ),
          error: (error, stack) => AppBar(
            title: Text('Error: $error'),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(
                MediaQuery.of(context).size.height > smallDeviceThreshold
                    ? 10
                    : 5),
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
                        ? gameStartResetButton(context, () {
                            // Button to pause timer
                            gameNotifier.pauseTimer();
                          }, 'assets/icons/pause-button.png',
                            MColors().colorPrimary)
                        : gameStartResetButton(context, () {
                            gameNotifier.playTimer(); // Button to start timer
                          }, 'assets/images/play.png', MColors().colorPrimary),
                    Gap(MediaQuery.of(context).size.height >
                            smallDeviceThreshold
                        ? 20
                        : 10),
                    gameStartResetButton(context, () {
                      switchQuestion(questions, gameState, gameNotifier);
                    }, 'assets/images/reset.png',
                        MColors().colorSecondaryBlueDark),
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
                    ? 70
                    : 35),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GameWidget(onMarkDonePressed: () {
                      onMarkDone(gameNotifier, gameState);
                    }),
                    Gap(MediaQuery.of(context).size.height >
                            smallDeviceThreshold
                        ? 70
                        : 35),
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
                          onMarkDone(gameNotifier, gameState);
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
