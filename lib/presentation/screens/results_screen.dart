import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/domain/entities/question.dart';
import 'package:xpuzzle/presentation/providers/result_provider.dart';
import '../../data/models/remote/style_card_model.dart';
import '../providers/level_provider.dart';
import '../providers/question/question_provider.dart';
import '../theme/colors.dart';
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
    final questions = ref.watch(questionProvider).questions;
    final level = ref.read(levelProvider);
    var resultScreen = ref.watch(resultProvider);

    int totalCorrectAns() {
      int totalCorrect = 0;
      for (Question question in questions) {
        if (question.isCorrect) {
          totalCorrect++;
        }
      }
      return totalCorrect;
    }

    return Scaffold(
      appBar: customAppBar(
          context,
          "All Result", // Pass the current level here
          SvgPicture.asset(
            "assets/icons/svg/back_icon.svg",
            width: 50,
            height: 35,
          ),
          Image.asset("assets/images/print_icon.png"),
          onPressedLeading: () {},
          titleColor: Colors.black),
      body: Container(
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

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                level.when(data: (data) {
                  return LevelsHeader(
                    level: data ?? "",
                    style: getStyle(resultScreen),
                    totalQuestions: questions.length,
                    correct: totalCorrectAns(),
                  );
                }, error: (err, stack) {
                  return LevelsHeader(
                    level: "",
                    style: getStyle(resultScreen),
                    totalQuestions: questions.length,
                    correct: totalCorrectAns(),
                  );
                }, loading: () {
                  return LevelsHeader(
                    level: "Loading....",
                    style: getStyle(resultScreen),
                    totalQuestions: questions.length,
                    correct: totalCorrectAns(),
                  );
                }),
                Gap(MediaQuery.of(context).size.height * 0.02),
                Expanded(
                  child: questions.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(
                              color: MColors().colorSecondaryBlueLight),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: questions.length,
                          itemBuilder: (BuildContext context, int index) {
                            var question = questions[index];
                            return ResultSingleCard(question: question);
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
