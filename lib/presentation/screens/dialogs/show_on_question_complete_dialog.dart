import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpuzzle/presentation/theme/colors.dart';
import 'package:xpuzzle/utils/constants.dart';

import '../../widgets/buttons/buttons.dart';

void showOnQuestionCompleteDialog(
    {required BuildContext context,
    required void Function() onNext,
    required void Function() onClose,
    void Function()? onTryAgain,
    bool isCorrectAnswer = true}) {
  final double headingTextSize =
      context.screenHeight > smallDeviceThreshold ? 21 : 18;
  final double bodyTextSize =
      context.screenHeight > smallDeviceThreshold ? 16 : 12;
  final double bodyItemSpace =
      context.screenHeight > smallDeviceThreshold ? 10 : 8;
  final double buttonWidth = context.screenHeight * 0.33;
  final double textFieldWidth = context.screenWidth * 0.7;

 // Timer? _timer;

  void closeDialog() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      onNext();
    }
  }

  showGeneralDialog(
      context: context,
      pageBuilder: (ctx, anim1, anim2) => const SizedBox.shrink(),
      transitionBuilder: (ctx, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: anim1,
              curve: Curves.easeOutBack,
              reverseCurve: Curves.easeIn,
            ),
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27)),
              child: IntrinsicHeight(
                child: Container(
                  // height: context.screenHeight > smallDeviceThreshold
                  //     ? context.screenHeight * 0.48
                  //     : context.screenHeight * 0.44,
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 35),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(27),
                      color: MColors().beigeColor),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              /*if (_timer != null && _timer.isActive) {
                                _timer.cancel();
                                // Cancel the timer before closing the dialog
                              }*/
                              closeDialog();
                            },
                            icon: SvgPicture.asset(
                                "assets/icons/svg/icon_close.svg")),
                      ),
                      // SizedBox(
                      //   height: context.screenHeight > smallDeviceThreshold
                      //       ? 15
                      //       : 10,
                      // ),
                      SizedBox(
                        height: context.screenHeight * 0.3,
                        width: isCorrectAnswer
                            ? context.screenWidth * 0.5
                            : context.screenWidth * 1,
                        child: isCorrectAnswer
                            ? Column(mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    const Text(
                                      "CORRECT \nANSWER",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'BalooDa2',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 28,
                                        color: Colors
                                            .black, // Set the text color to black
                                      ),
                                    ),
                                  SizedBox(
                                    height: context.screenHeight * 0.04,
                                  ),
                                    SizedBox(
                                      width: buttonWidth,
                                      child: gradientButton(context, () {
                                        closeDialog();
                                      }, "Next", 15),
                                    )
                                  ])
                            : SvgPicture.asset(
                                fit: BoxFit.fill,
                                "assets/icons/svg/heading_incorrect_answer.svg"),
                      ),

                      if (!isCorrectAnswer)
                        Column(
                          children: [
                            SizedBox(
                              width: textFieldWidth,
                              child: Text(
                                "Almost There!\nNot quite, but keep going!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'BalooDa2',
                                    fontSize: headingTextSize,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              width: context.screenWidth * 0.7,
                              child: const Opacity(
                                opacity: 0.6,
                                child: Text(
                                  "Try another question to keep learning.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'BalooDa2',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: isCorrectAnswer
                                  ? context.screenHeight * 0.07
                                  : context.screenHeight * 0.05,
                            ),
                            SizedBox(
                              width: buttonWidth,
                              child: gameDoneButton(() {
                                onTryAgain!();
                                Navigator.pop(context);
                              }, context, "Try Again",
                                  borderRadius: 15,
                                  fontSize: context.screenHeight >
                                          smallDeviceThreshold
                                      ? 15
                                      : 13),
                            ),
                            SizedBox(
                              height: context.screenHeight * 0.02,
                            ),
                            SizedBox(
                              width: buttonWidth,
                              child: gradientButton(context, () {
                                onNext();
                                Navigator.pop(context);
                              }, "Next", 15),
                            ),
                            SizedBox(
                              height: isCorrectAnswer
                                  ? context.screenHeight * 0.07
                                  : context.screenHeight * 0.05,
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200));

  // Schedule the dialog to close after 2 seconds
  /*if (isCorrectAnswer) {
    _timer = Timer(const Duration(seconds: 2), () {
      closeDialog();
    });
  }*/
}
