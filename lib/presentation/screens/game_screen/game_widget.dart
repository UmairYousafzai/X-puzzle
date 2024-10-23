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
          FractionallySizedBox(
            widthFactor: 0.5,
            child: SvgPicture.asset(
              'assets/icons/svg/purple_cross.svg',
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height > smallDeviceThreshold
                ? context.screenHeight * 0.07
                : context.screenHeight * 0.042,
            left: 0,
            right: 0,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.screenHeight * 0.05),
              child: Column(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      gameNumberTextField(
                        value: gameState.firstNumber,
                        context: context,
                        fontSize: 22,
                        onChanged: gameNotifier.updateFirstNumber,
                        focusNode: firstNumberFocus,
                      ),
                      const Gap(10),
                      gameNumberTextField(
                        value: gameState.secondNumber,
                        context: context,
                        fontSize: 22,
                        onChanged: gameNotifier.updateSecondNumber,
                        focusNode: secondNumberFocus,
                      ),
                    ],
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
                  gameDoneButton(onMarkDonePressed, context),
                  Gap(context.screenHeight * 0.02),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
