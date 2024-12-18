import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/presentation/providers/result_provider.dart';
import 'package:xpuzzle/presentation/screens/results_screen.dart';
import 'package:xpuzzle/presentation/theme/colors.dart';

import '../../data/models/remote/style_card_model.dart';
import '../../domain/entities/question.dart';
import '../../utils/constants.dart';
import '../providers/level_provider.dart';
import '../providers/question/question_provider.dart';
import '../providers/time/time_use_case_provider.dart';
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
      getTime();
      getPersonalBestTime();
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

  void getTime() async {
    final timeUseCaseProvider = ref.watch(getTimeUseCaseProvider);
    var state = ref.watch(resultProvider);

    var result = await timeUseCaseProvider.execute(
        isPPAndPS: state["isPPAndPS"],
        isPPAndNS: state["isPPAndNS"],
        isNPAndPS: state["isNPAndPS"],
        isNPAndNS: state["isNPAndNS"]);
    String time = result!.minutes != 0
        ? "Time ${(5 - result.minutes)}min"
        : "Time ${result.seconds}sec";

    ref.watch(resultProvider.notifier).setTime(time);
  }

  void getPersonalBestTime() async {
    final timeByTypeUseCaseProvider = ref.watch(getTimeByTypeUseCaseProvider);
    var state = ref.watch(resultProvider);
    var result = await timeByTypeUseCaseProvider.execute(
        isPPAndPS: state["isPPAndPS"],
        isPPAndNS: state["isPPAndNS"],
        isNPAndPS: state["isNPAndPS"],
        isNPAndNS: state["isNPAndNS"]);
    result?.sort((a, b) {
      int totalSecondsA = a.minutes * 60 + a.seconds;
      int totalSecondsB = b.minutes * 60 + b.seconds;
      return totalSecondsB.compareTo(totalSecondsA); // Descending order
    });
    try {
      var time = (((result?.first.minutes ?? 0) * 60) + result!.first.seconds)
              / 60;
      String timeString =
              "$time min";
      ref.watch(resultProvider.notifier).setBestTime(timeString);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    var resultScreen = ref.watch(resultProvider);
    final level = ref.read(levelProvider);

    final questions = ref
        .watch(questionProvider)
        .questions;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
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
                              style: TextStyle(
                                fontFamily: 'BalooDa2',
                                color: Colors.black,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w700,
                              ),
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
              8.verticalSpace,
              level.when(data: (data) {
                return LevelsHeader(
                  level: data ?? "",
                  style: resultScreen["time"],
                  totalQuestions: questions.length,
                  correct: totalCorrectAns(questions),
                );
              }, error: (err, stack) {
                return LevelsHeader(
                  level: "",
                  style: resultScreen["time"],
                  totalQuestions: questions.length,
                  correct: totalCorrectAns(questions),
                );
              }, loading: () {
                return LevelsHeader(
                  level: "Loading....",
                  style: resultScreen["time"],
                  totalQuestions: questions.length,
                  correct: totalCorrectAns(questions),
                );
              }),
              const Gap(10),
              Container(
                width: 334.w,
                height: 585.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: MColors().beigeColor
                  // image: const DecorationImage(
                  //     image: AssetImage(
                  //         "assets/images/background_congratulations.png"),
                  //     fit: BoxFit.cover)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SvgPicture.asset(
                            width: 234.w,
                            height: 69.h,
                            'assets/svgs/personal_best_time_bg.svg',
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 15.h,
                            bottom: 0,
                            left: 25.w,
                            right: 25.w,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Your Personal Best",
                                  style: TextStyle(
                                    fontFamily: 'BalooDa2',
                                    color: Colors.black,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                15.horizontalSpace,
                                Text(
                                  resultScreen["best_time"]??"",
                                  style: TextStyle(
                                    fontFamily: 'BalooDa2',
                                    color: MColors().colorSecondaryOrangeDark,
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      12.verticalSpace,
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              width: 266.5.w,
                              height: 241.h,
                              'assets/svgs/party_sparkle.svg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Image.asset(
                                width: 241.w,
                                height: 90.h,
                                'assets/images/great_job.png'),
                          ),
                        ],
                      ),
                      Center(
                        child: Text(
                          quizCompletedLabel,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'BalooDa2',
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
                          style: TextStyle(
                              fontFamily: 'BalooDa2',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              height: 2,
                              color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                      const Gap(15),
                      viewCompleteResultsButton(() {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ResultsScreen()),
                              (Route<dynamic> route) {
                            return route.isFirst;
                          },
                        );
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
