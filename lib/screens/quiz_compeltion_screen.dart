import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/screens/widgets/levels_header.dart';

import '../models/remote/style_card_model.dart';
import '../utils/constants.dart';

class QuizCompeltionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(""),
                  Text(
                    "Home",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SvgPicture.asset("assets/images/svgs/cancel_icon.svg")
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),

                  Column(
                    children: [
                      LevelsHeader(
                        level: "Level 1",
                        style: Styles.style2,
                        totalQuestions: 12,
                        correct: 8,
                      ),
                    

                      Container(
                        width: scWidth(context),
                        height: scHeight(context)*0.7,
                        decoration:  BoxDecoration(
                            borderRadius:  BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                            image: DecorationImage(
                                image: AssetImage("assets/images/background_congratulations.png"),

                            )
                        ),
                        child: Column(
                          children: [
                            Text("dsdsd"),
                            SvgPicture.asset("assets/images/svgs/great_job.svg"),
                            


                          ],
                        ),
                      )
                    ],
                  )

            ]),
          ),
        ),

    );


  }
}
