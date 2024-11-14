import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

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
      width: context.screenWidth * 0.9,
      height: context.screenHeight * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: MColors().colorPrimary,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/svg/purple_cross.svg',
              fit: BoxFit.contain,
              height: context.screenHeight > smallDeviceThreshold
                  ? context.screenHeight * 0.21
                  : context.screenHeight * 0.21,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height > smallDeviceThreshold
                ? context.screenHeight * 0.074
                : context.screenHeight * 0.04,
            left: 0,
            right: 0,

            child: /*Padding(
              padding:
                  EdgeInsets.only(left: context.screenHeight * 0.05,right: context.screenHeight * 0.05,
                    top: context.screenHeight > largeDeviceThreshold?context.screenHeight*0.010 :context.screenHeight*0.008,
              ),
              child: */Column(
                children: [
                  Gap(context.screenHeight * 0.01),
                  Text(
                    'Enter Number',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: MColors().colorSecondaryBlueDark, fontSize: 18),
                  ),
                  Gap(context.screenHeight * 0.01),
                  Text(
                    'X',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: MColors().colorSecondaryOrangeDark),
                  ),
                  Text(
                    gameState.question?.topNum ?? "",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  const Gap(5),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal:context.screenWidth*0.12),
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
                        const Gap(10),
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
                  const Gap(5),
                  Text(
                    gameState.question?.bottomNum ?? "",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  Gap(context.screenHeight * 0.066),
                  gameDoneButton(
                    onMarkDonePressed,
                    context,
                    "Mark Done",
                  ),
                  Gap(context.screenHeight * 0.02),
                ],
              ),
            /*),*/
          ),
        ],
      ),
    );
  }
}
