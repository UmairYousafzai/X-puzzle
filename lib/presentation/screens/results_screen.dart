import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:xpuzzle/utils/constants.dart';

import '../../data/models/remote/style_card_model.dart';
import '../widgets/levels_header.dart';
import '../widgets/result_single_card.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background_1.jpeg"),
                fit: BoxFit.fill)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   IconButton( onPressed: () {Navigator.pop(context);  }, icon: const Icon(Icons.arrow_back),),
                  Text(
                    "Home",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                          image: AssetImage(
                              "assets/images/place_holder_profile.png"),
                          fit: BoxFit.fill),
                    ),
                    child: const Text(""),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              ////Header Design
              const LevelsHeader(
                level: "Level 1",
                style: Styles.style2,
                totalQuestions: 12,
                correct: 8,
              ),
              Gap(context.screenHeight*0.02),
              Expanded(
                child: SizedBox(
                  height: context.screenHeight*0.8,
                  child:
                  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: 30,
                    itemBuilder: (BuildContext context, int index) {
                      return const ResultSingleCard
                        (isCorrect: false);
                    },
                  ),
                ),
              )

            ]),
          ),
        ),
      ),
    );
  }
}
