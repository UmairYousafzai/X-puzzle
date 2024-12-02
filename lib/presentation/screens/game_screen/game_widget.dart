import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/main.dart';

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
print("game widget  ${context.screenWidth}");
print("game widget cal ${context.screenWidth< smallDeviceThreshold ?45:65}");
    return Container(
      width: 306.w,
      height: 340.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: MColors().colorPrimary,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {

          var widgetTopPosition= 0.0;
          if(context.screenHeight<smallDeviceThreshold){
            widgetTopPosition= 45.h;
          }else if(context.screenHeight > 600 && context.screenHeight<800){
            widgetTopPosition= 60.h;

          }else if(context.screenHeight >800){
            widgetTopPosition= 65.h;

          }


          return Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              Align(
                child: SvgPicture.asset(
                  'assets/icons/svg/purple_cross.svg',
                  fit: BoxFit.contain,
                  height: 134.h,
                  width: 134.w,
                ),
              ),
              Positioned(
                top: 22.r,
                child: Column(
                  children: [
                    Text(
                      'Enter Number',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
                  children: [
                    8.verticalSpace,
                    // SizedBox(height: containerHeight * 0.040),
                    Text(
                      'X',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w700,
                          color: MColors().colorSecondaryOrangeDark),
                    ),
                    Text(
                      gameState.question?.topNum ?? "",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
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
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    // SizedBox(height: containerHeight * 0.10),

                    25.verticalSpace,
                    Align(
                      alignment: Alignment.bottomCenter,
                      child:  gameDoneButton(
                        onMarkDonePressed,
                        context,
                        "Mark Done",
                      )
                      ,
                    )
                   ,
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
