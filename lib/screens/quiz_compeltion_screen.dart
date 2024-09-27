import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuizCompeltionScreen extends StatelessWidget {
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
            ]),
          ),
        ),
      ),
    );

    /* Scaffold(

      body:Column(
        children: [
          LevelsHeader(
            level: "Level 1",
            style: Styles.style2,
            totalQuestions: 12,
            correct: 8,
          ),
          Gap(scHeight(context)*0.02),

          Container(
            decoration: const BoxDecoration(
              borderRadius:  BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
              image: DecorationImage(
                image: AssetImage("assets/images/background_congratulations.png"),
                fit: BoxFit.fill
              )
            ),
            child: Column(
              children: [

              ],
            ),
          )
        ],
      )
      ,
    );*/
  }
}
