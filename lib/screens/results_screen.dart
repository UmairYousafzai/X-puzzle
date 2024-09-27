import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/models/remote/style_card_model.dart';
import 'package:xpuzzle/screens/widgets/levels_header.dart';
import 'package:xpuzzle/screens/widgets/result_single_card.dart';
import 'package:xpuzzle/utils/constants.dart';

class ResultsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: new AssetImage("assets/images/background_1.jpeg"),
                fit: BoxFit.fill)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.arrow_back,size: 40),
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
                  LevelsHeader(
                    level: "Level 1",
                    style: Styles.style2,
                    totalQuestions: 12,
                    correct: 8,
                  ),
                  Gap(scHeight(context)*0.02),
                  SizedBox(
                    height: scHeight(context)*0.8,
                    child:
                  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: 30,
                    itemBuilder: (BuildContext context, int index) {
                      return ResultSingleCard
                        (isCorrect: false);
                    },
                  ),
                  )

            ]),
          ),
        ),
      ),
    );
  }
}
