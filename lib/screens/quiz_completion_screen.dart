import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/screens/results_screen.dart';
import 'package:xpuzzle/screens/widgets/buttons/buttons.dart';
import 'package:xpuzzle/screens/widgets/levels_header.dart';

import '../models/remote/style_card_model.dart';
import '../utils/constants.dart';

class QuizCompletionScreen extends StatelessWidget {
  const QuizCompletionScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              LevelsHeader(
                level: "Level 1",
                style: Styles.style2,
                totalQuestions: 12,
                correct: 8,
              ),
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
                                builder: (ctx) => ResultsScreen()));
                      }, context),
                      const Gap(15),
                      primaryButton(
                          () {}, 'Explore More', Colors.white, context),
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
