import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/domain/entities/question.dart';
import 'package:xpuzzle/utils/constants.dart';

import '../theme/colors.dart';

class ResultSingleCard extends StatelessWidget {
  final Question question;

  const ResultSingleCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 15.h),
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
            6.5.verticalSpace,
            Text(question.isCorrect ? "Correct" : "wrong",
                style: TextStyle(
                    fontFamily: 'BalooDa2',
                    fontSize: 16.sp,
                    color: question.isCorrect
                        ? MColors().colorSecondaryBlueDark
                        : MColors().colorSecondaryOrangeDark,
                    fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SvgPicture.asset(
                    "assets/images/svgs/cross_sign.svg",
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("x",
                                  style: TextStyle(
                                      color: MColors().colorSecondaryOrangeDark,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                question.topNum,
                                style: const TextStyle(
                                      fontFamily: 'BalooDa2',
                                      fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: Tooltip(
                              message: question.inputNumOne,
                              child: Container(
                                width: context.screenWidth * 0.08,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: MColors().colorSecondaryBlueLighter),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 3.0, top: 3, right: 3, bottom: 3),
                                  child: Text(
                                    question.inputNumOne,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            MColors().colorSecondaryBlueDark),
                                    // Add ellipsis for long text
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          Flexible(
                            child: Tooltip(
                              message: question.inputNumTwo,
                              child: Container(
                                width: context.screenWidth * 0.08,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: MColors().colorSecondaryBlueLighter),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 3.0, top: 3, right: 3, bottom: 3),
                                  child: Text(
                                    question.inputNumTwo,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            MColors().colorSecondaryBlueDark),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            question.bottomNum,
                            style: const TextStyle(
                                fontFamily: 'BalooDa2',
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Text("+",
                style: TextStyle(
                    color: MColors().colorSecondaryOrangeDark,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
