
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/domain/entities/question.dart';
import 'package:xpuzzle/utils/constants.dart';

import '../theme/colors.dart';

class ResultSingleCard extends StatelessWidget{
  final Question question;
  const ResultSingleCard({super.key, required this.question});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 10),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(question.isCorrect?"Correct":"wrong",style:Theme.of(context).textTheme.titleMedium!.copyWith(
                color: question.isCorrect?MColors().colorSecondaryBlueDark:MColors().colorSecondaryOrangeDark,
                fontWeight: FontWeight.bold
            )),
            Padding(
              padding: const EdgeInsets.only(top:3.0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SvgPicture.asset("assets/images/svgs/cross_sign.svg"),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              Text("x",style: TextStyle(
                                  color: MColors().colorSecondaryOrangeDark,
                                  fontWeight: FontWeight.bold
                              )),
                              Text(question.topNum,style: TextStyle(fontWeight: FontWeight.bold),)
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: MColors().colorSecondaryBlueLighter
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0,top: 3,right: 5,bottom: 3),
                              child: Text(question.numOne,style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: MColors().colorSecondaryBlueDark
                              ),),
                            ),
                          ),
                          const Gap(10),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: MColors().colorSecondaryBlueLighter
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0,top: 3,right: 5,bottom: 3),
                              child: Text(question.numTwo,style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: MColors().colorSecondaryBlueDark
                              ),),
                            ),
                          ),

                        ],
                      ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(question.bottomNum,style: TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}