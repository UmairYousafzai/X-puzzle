import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/domain/entities/question.dart';
import 'package:xpuzzle/main.dart';
import 'package:xpuzzle/presentation/providers/result_provider.dart';
import 'package:xpuzzle/presentation/providers/time/time_use_case_provider.dart';
import 'package:xpuzzle/presentation/screens/question_pdf.dart';
import 'package:xpuzzle/presentation/widgets/snackBar_messages.dart';
import 'package:xpuzzle/utils/constants.dart';
import '../providers/question/question_provider.dart';
import '../theme/colors.dart';
import '../widgets/buttons/buttons.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/levels_header.dart';
import '../widgets/result_single_card.dart';

class ResultsScreen extends ConsumerStatefulWidget {
  const ResultsScreen({super.key});

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends ConsumerState<ResultsScreen> {
  @override
  void initState() {
    super.initState();
    Future(() {
      getTime();
    });
  }

  String getStyle(Map<String, dynamic> state) {
    if (state["isPPAndPS"]) {
      return "Level 1";
    } else if (state["isPPAndNS"]) {
      return "Level 2";
    } else if (state["isNPAndPS"]) {
      return "Level 3";
    } else if (state["isNPAndNS"]) {
      return "Level 4";
    } else {
      return "";
    }
  }

  int totalCorrectAns() {
    int totalCorrect = 0;
    for (Question question in ref.watch(questionProvider).questions) {
      if (question.isCorrect) {
        totalCorrect++;
      }
    }
    return totalCorrect;
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

  @override
  Widget build(BuildContext context) {
    final questions = ref.watch(questionProvider).questions;
    // final level = ref.read(levelProvider);
    var resultScreen = ref.watch(resultProvider);
    var resultScreenNotifier = ref.watch(resultProvider.notifier);

    return Scaffold(
    body: Stack(
      children: [
        GestureDetector(
        onHorizontalDragEnd: (details) {
          if (Platform.isIOS) {
            if (details.primaryVelocity != null &&
                details.primaryVelocity! > 0) {
              Navigator.pop(context);
              if (kDebugMode) {
                print("Left to right swipe detected");
              }
            }
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_1.jpeg"),
              fit: BoxFit.fill,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customAppBar(
                      context,
                      "All Results", // Pass the current level here
                      null,
                      Image.asset("assets/images/print_icon.png"),
                      onPressedLeading: null, onPressedAction: () async {
                        if (kDebugMode) {
                          print("loading value -=======> ${resultScreen["is_loading"]}");
                        }
                    if (!resultScreen["is_loading"]) {
                      resultScreenNotifier.setLoading(true);
                     var flag= await generatePDF(
                          isPPAndPS: resultScreen["isPPAndPS"],
                          isPPAndNS: resultScreen["isPPAndNS"],
                          isNPAndPS: resultScreen["isNPAndPS"],
                          isNPAndNS: resultScreen["isNPAndNS"]);
                      if (flag) {
                        if (Platform.isAndroid) {
                          showSuccessSnackBar(
                              context, "File saved to downloads");
                        }
                      } else {
                        showErrorSnackBar(
                            context, "Failed to save file.");
                      }
                      resultScreenNotifier.setLoading(false);

                    }
                  }, titleColor: Colors.black),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  LevelsHeader(
                    level: getStyle(resultScreen),
                    style: resultScreen["time"],
                    totalQuestions: questions.length,
                    correct: totalCorrectAns(),
                  ),
                  // level.when(data: (data) {
                  //   return LevelsHeader(
                  //     level: data ?? "",
                  //     style: resultScreen["time"],
                  //     totalQuestions: questions.length,
                  //     correct: totalCorrectAns(),
                  //   );
                  // }, error: (err, stack) {
                  //   return LevelsHeader(
                  //     level: "",
                  //     style: resultScreen["time"],
                  //     totalQuestions: questions.length,
                  //     correct: totalCorrectAns(),
                  //   );
                  // }, loading: () {
                  //   return LevelsHeader(
                  //     level: "Loading....",
                  //     style: resultScreen["time"],
                  //     totalQuestions: questions.length,
                  //     correct: totalCorrectAns(),
                  //   );
                  // }),
                  Gap(MediaQuery.of(context).size.height * 0.02),
                  Expanded(
                    child: questions.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(
                                color: MColors().colorSecondaryBlueLight),
                          )
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.63.h,
                            ),
                            itemCount: questions.length,
                            itemBuilder: (BuildContext context, int index) {
                              var question = questions[index];
                              return ResultSingleCard(question: question);
                            },
                          ),
                  ),
                  primaryButton(() {
                      Navigator.pop(context);

                  }, 'Explore More', Colors.white, context),
                  Gap(MediaQuery.of(context).size.height * 0.01),
                ],
              ),
            ),
          ),
        ),
      ),
        if(resultScreen["is_loading"])Container(
          color: Colors.white.withOpacity(0.5),
          width: context.screenWidth,
          height: context.screenHeight,
          child: Center(
            child: CircularProgressIndicator(color: MColors().colorSecondaryBlueDark,),
          ),
        ),],
    ),
          );
  }
}
