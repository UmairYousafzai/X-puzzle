import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(27),
                      color: MColors().beigeColor),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
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
                          height: isCorrectAnswer? context.screenHeight * 0.3: context.screenHeight * 0.3,
                          width:isCorrectAnswer?  context.screenWidth * 0.5: context.screenWidth * 1,
                          child: SvgPicture.asset(
                              fit: BoxFit.fill,
                              isCorrectAnswer
                                  ? "assets/icons/svg/heading_correct_answer.svg"
                                  : "assets/icons/svg/heading_incorrect_answer.svg")),
                      SizedBox(
                        width: textFieldWidth,
                        child: Text(
                          isCorrectAnswer
                              ? "You've completed this\nchallenge!"
                              : "Almost There!\nNot quite, but keep going!",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontSize: headingTextSize,
                                  fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        width: context.screenWidth * 0.7,
                        child: Opacity(
                          opacity: 0.6,
                          child: Text(
                            isCorrectAnswer
                                ? "Keep challenging yourself with more questions to deepen your knowledge!"
                                : "Try another question to keep learning.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: isCorrectAnswer? context.screenHeight * 0.07 : context.screenHeight* 0.05,
                      ),
                      if (!isCorrectAnswer)
                        SizedBox(
                          width: buttonWidth,
                          child: gameDoneButton(
                            () {
                              onTryAgain!();
                              Navigator.pop(context);
                            },
                            context,
                            "Try Again",
                            borderRadius: 15,
                            fontSize: context.screenHeight>smallDeviceThreshold?15:13
                          ),
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
                        height: isCorrectAnswer? context.screenHeight * 0.07 : context.screenHeight* 0.05,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200));
}
