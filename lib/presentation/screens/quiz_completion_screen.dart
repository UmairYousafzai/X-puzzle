import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/presentation/providers/result_provider.dart';
import 'package:xpuzzle/presentation/screens/results_screen.dart';

import '../../data/models/remote/style_card_model.dart';
import '../../domain/entities/question.dart';
import '../../utils/constants.dart';
import '../providers/level_provider.dart';
import '../providers/question/question_provider.dart';
import '../widgets/buttons/buttons.dart';
import '../widgets/levels_header.dart';

class QuizCompletionScreen extends ConsumerStatefulWidget {
  const QuizCompletionScreen({super.key});

  @override
  _QuizCompletionScreen createState() {
    return _QuizCompletionScreen();
  }
}

class _QuizCompletionScreen extends ConsumerState<QuizCompletionScreen> {
  @override
  void initState() {
    super.initState();

    Future(() {
      fetchQuestions();
    });
  }

  Future<void> fetchQuestions() async {
    var resultState = ref.watch(resultProvider);

    await ref.watch(questionProvider.notifier).fetchQuestion(
        isPPAndPS: resultState["isPPAndPS"],
        isPPAndNS: resultState["isPPAndNS"],
        isNPAndPS: resultState["isNPAndPS"],
        isNPAndNS: resultState["isNPAndNS"]);
  }

  int totalCorrectAns(List<Question> questions) {
    int totalCorrect = 0;
    for (Question question in questions) {
      if (question.isCorrect) {
        totalCorrect++;
      }
    }
    return totalCorrect;
  }

  String getStyle(Map<String, dynamic> state) {
    if (state["isPPAndPS"]) {
      return "Style 1";
    } else if (state["isPPAndNS"]) {
      return "Style 2";
    } else if (state["isNPAndPS"]) {
      return "Style 3";
    } else if (state["isNPAndNS"]) {
      return "Style 4";
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    var resultScreen = ref.watch(resultProvider);
    final level = ref.read(levelProvider);

    final questions = ref.watch(questionProvider).questions;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: 0,
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.close)),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "Result",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close)),
                        //SvgPicture.asset("assets/images/svgs/cancel_icon.svg"),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(context.screenHeight * 0.03),
              level.when(data: (data) {
                return LevelsHeader(
                  level: data,
                  style: getStyle(resultScreen),
                  totalQuestions: questions.length,
                  correct: totalCorrectAns(questions),
                );
              }, error: (err, stack) {
                return LevelsHeader(
                  level: "",
                  style: getStyle(resultScreen),
                  totalQuestions: questions.length,
                  correct: totalCorrectAns(questions),
                );
              }, loading: () {
                return LevelsHeader(
                  level: "Loading....",
                  style: getStyle(resultScreen),
                  totalQuestions: questions.length,
                  correct: totalCorrectAns(questions),
                );
              }),
              const Gap(10),
              Container(
                width: context.screenWidth * 0.95,
                height: context.screenHeight * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                        image: AssetImage(
                            "assets/images/background_congratulations.png"),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Gap(context.screenHeight * 0.15),
                      Image.asset('assets/images/great_job.png'),
                      Gap(context.screenHeight * 0.14),
                      Center(
                        child: Text(
                          quizCompletedLabel,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(0.8)),
                        ),
                      ),
                      const Gap(15),
                      Center(
                        child: Text(
                          playMoreQuizLabel,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 2,
                                  color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                      const Gap(15),
                      viewCompleteResultsButton(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => const ResultsScreen()));
                      }, context),
                      const Gap(15),
                      primaryButton(() {
                        Navigator.pop(context);
                      }, 'Explore More', Colors.white, context),
                    ],
                  ),
                ),
              ),
              Gap(context.screenHeight * 0.03)
            ]),
          ),
        ),
      ),
    );
  }
}
