import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xpuzzle/presentation/screens/results_screen.dart';
import 'package:xpuzzle/presentation/theme/colors.dart';
import 'package:xpuzzle/utils/constants.dart';

import '../../widgets/buttons/buttons.dart';

void showStyleCompletedCustomDialog(BuildContext context,
    void Function() onViewResult, void Function() onTryAgain) {

  final double headingTextSize =
      context.screenHeight > smallDeviceThreshold ? 18 : 14;
  final double bodyTextSize =
      context.screenHeight > smallDeviceThreshold ? 16 : 12;
  final double bodyItemSpace =
      context.screenHeight > smallDeviceThreshold ? 10 : 8;
  final double buttonWidth = context.screenHeight * 0.33;
  final double textFieldWidth =  context.screenWidth * 0.6;

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
              child: Container(
                height: context.screenHeight > smallDeviceThreshold
                    ? context.screenHeight * 0.48
                    : context.screenHeight * 0.44,
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
                    SizedBox(
                      height:
                          context.screenHeight > smallDeviceThreshold ? 15 : 10,
                    ),
                    SizedBox(
                      width: textFieldWidth,
                      child: Opacity(
                        opacity: 0.6,
                        child: Text(
                          "Would you like to view your completed results",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: headingTextSize,
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: bodyItemSpace,
                    ),
                    SizedBox(
                      width: buttonWidth,
                      child: gameDoneButton(
                        () {
                          onViewResult();
                          Navigator.pop(context);
                        },
                        context,
                        "View Results",
                        borderRadius: 15,
                        paddingHorizontal: 0.06,
                          fontSize: context.screenHeight>smallDeviceThreshold?15:13
                      ),
                    ),
                    SizedBox(
                      height: bodyItemSpace,
                    ),
                    SizedBox(
                      width: textFieldWidth,
                      child: Opacity(
                        opacity: 0.6,
                        child: Text(
                          "or\n Would you like to try again",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: bodyTextSize,
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: bodyItemSpace,
                    ),
                    SizedBox(
                      width: buttonWidth,
                      child: gradientButton(context, () {
                        onTryAgain();
                        Navigator.pop(context);
                      }, "Try Again", 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300));

}
