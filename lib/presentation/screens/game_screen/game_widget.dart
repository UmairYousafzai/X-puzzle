import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xpuzzle/utils/constants.dart';

import '../../providers/game_provider.dart';
import '../../theme/colors.dart';
import '../../widgets/buttons/buttons.dart';
import '../../widgets/custom_fields/game_number_field_widget.dart';

// Providers for focus nodes

class GameWidget extends ConsumerWidget {
  const GameWidget({super.key, required this.onMarkDonePressed});

  final VoidCallback onMarkDonePressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);
    final gameNotifier = ref.read(gameProvider.notifier);
    final firstNumberFocus = ref.watch(gameProvider).firstNumberFocus;
    final secondNumberFocus = ref.watch(gameProvider).secondNumberFocus;

    return Container(
      width: 306.w,
      height: 340.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: MColors().colorPrimary,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          var widgetTopPosition = 0.0;
          if (context.screenHeight < smallDeviceThreshold) {
            widgetTopPosition = 83.h;
          } else if (context.screenHeight > 600 && context.screenHeight < 800) {
            widgetTopPosition = 87.h;
          } else if (context.screenHeight > 800) {
            widgetTopPosition = 88.h;
          }

          return Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              Align(
                child: SvgPicture.asset(
                  'assets/icons/svg/purple_cross.svg',
                  fit: BoxFit.contain,
                  height: 150.h,
                  width: 150.w,
                ),
              ),
              Positioned(
                top: 22.r,
                child: Column(
                  children: [
                    Text(
                      'Enter Number',
                      style: TextStyle(
                          fontFamily: 'BalooDa2',
                          fontWeight: FontWeight.w600,
                          color: MColors().colorSecondaryBlueDark,
                          fontSize: 19.sp),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: widgetTopPosition,
                right: 0,
                left: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (context.screenHeight > mediumDeviceThreshold)
                      6.verticalSpace,
                    // SizedBox(height: containerHeight * 0.040),
                    Text(
                      'X',
                      style: TextStyle(
                          fontFamily: 'BalooDa2',
                          fontSize: 28.sp,
                          height: 0.5,
                          fontWeight: FontWeight.w700,
                          color: MColors().colorSecondaryOrangeDark),
                    ),
                    Text(
                      gameState.question?.topNum ?? "",
                      style: TextStyle(
                          fontFamily: 'BalooDa2',
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    if (context.screenHeight > mediumDeviceThreshold)
                      5.verticalSpace,
                    // SizedBox(height:smallDeviceThreshold>context.screenHeight?containerHeight * 0.0:containerHeight*0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          gameNumberTextField(
                              value: gameState.firstNumber,
                              context: context,
                              fontSize: 22,
                              onChanged: gameNotifier.updateFirstNumber,
                              focusNode: firstNumberFocus,
                              hasError: gameState.hasErrorOnTextFieldOne),
                          0.horizontalSpace,
                          // SizedBox(width: containerWidth * 0.05),
                          gameNumberTextField(
                              value: gameState.secondNumber,
                              context: context,
                              fontSize: 22,
                              onChanged: gameNotifier.updateSecondNumber,
                              focusNode: secondNumberFocus,
                              hasError: gameState.hasErrorOnTextFieldTwo),
                        ],
                      ),
                    ),
                    5.verticalSpace,

                    // SizedBox(height: containerHeight * 0.01),

                    Text(
                      gameState.question?.bottomNum ?? "",
                      style: TextStyle(
                          fontFamily: 'BalooDa2',
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    // SizedBox(height: containerHeight * 0.10),
                    Text(
                      '+',
                      style: TextStyle(
                          fontFamily: 'BalooDa2',
                          fontSize: 30.sp,
                          height: 0.5.h,

                          fontWeight: FontWeight.w700,
                          color: MColors().colorSecondaryOrangeDark),
                    ),
                    25.verticalSpace,
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: gameDoneButton(
                        onMarkDonePressed,
                        context,
                        "Submit",
                      ),
                    ),
                    5.verticalSpace
                    // SizedBox(height: containerHeight * 0.01),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
