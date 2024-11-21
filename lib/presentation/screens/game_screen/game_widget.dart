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
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: MColors().colorPrimary,
      ),

      child: LayoutBuilder(
        builder: (context, constraints) {
          double containerWidth = constraints.maxWidth;
          double containerHeight = constraints.maxHeight;

          return Stack(
            alignment: Alignment.center,
            children: [
              Align(
                child: SvgPicture.asset(
                  'assets/icons/svg/purple_cross.svg',
                  fit: BoxFit.contain,
                  height: containerHeight * 0.4,
                ),
              ),
              Positioned(
                top: containerHeight * 0.14,
                child: Column(
                  children: [
                    Text(
                      'Enter Number',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: MColors().colorSecondaryBlueDark, fontSize: containerWidth * 0.05),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: smallDeviceThreshold>context.screenHeight?containerHeight * 0.21:containerHeight*0.245,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    SizedBox(height: containerHeight * 0.040),
                    Text(
                      'X',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: containerWidth * 0.06,
                          fontWeight: FontWeight.w700,
                          color: MColors().colorSecondaryOrangeDark),
                    ),
                    Text(
                      gameState.question?.topNum ?? "",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: containerWidth * 0.07,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    SizedBox(height:smallDeviceThreshold>context.screenHeight?containerHeight * 0.0:containerHeight*0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: containerWidth * 0.16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          gameNumberTextField(
                              value: gameState.firstNumber,
                              context: context,
                              fontSize: containerWidth * 0.05,
                              onChanged: gameNotifier.updateFirstNumber,
                              focusNode: firstNumberFocus,
                              hasError: gameState.hasErrorOnTextFieldOne),
                          SizedBox(width: containerWidth * 0.05),
                          gameNumberTextField(
                              value: gameState.secondNumber,
                              context: context,
                              fontSize: containerWidth * 0.05,
                              onChanged: gameNotifier.updateSecondNumber,
                              focusNode: secondNumberFocus,
                              hasError: gameState.hasErrorOnTextFieldTwo),
                        ],
                      ),
                    ),

                    SizedBox(height: containerHeight * 0.01),

                    Text(
                      gameState.question?.bottomNum ?? "",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: containerWidth * 0.07,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    SizedBox(height: containerHeight * 0.10),

                    gameDoneButton(
                      onMarkDonePressed,
                      context,
                      "Mark Done",
                    ),
                    SizedBox(height: containerHeight * 0.01),
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
