import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/screens/widgets/buttons/buttons.dart';
import 'package:xpuzzle/screens/widgets/custom_fields/game_number_field_widget.dart';
import 'package:xpuzzle/theme/colors.dart';
import 'package:xpuzzle/utils/constants.dart';

import '../../providers/game_provider.dart';

// Providers for focus nodes
final firstNumberFocusProvider = Provider((ref) => FocusNode());
final secondNumberFocusProvider = Provider((ref) => FocusNode());

class GameWidget extends ConsumerWidget {
  const GameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);
    final gameNotifier = ref.read(gameProvider.notifier);

    final firstNumberFocus = ref.watch(firstNumberFocusProvider);
    final secondNumberFocus = ref.watch(secondNumberFocusProvider);


    return Container(
      width: context.screenWidth * 0.9,
      height: context.screenHeight * 0.44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: MColors().colorPrimary,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          FractionallySizedBox(
            widthFactor: 0.5,
            child: Image.asset(
              'assets/images/purple_cross.png',
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: context.screenHeight * 0.03,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.screenHeight * 0.05),
              child: Column(
                children: [
                  Gap(context.screenHeight * 0.02),
                  Text(
                    'Enter Number',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: MColors().colorSecondaryBlueDark, fontSize: 18),
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
                    '18',
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
                    '9',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  Gap(context.screenHeight * 0.05),
                  gameDoneButton(() {
                    // Handle game completion logic here
                    print('Game completed with numbers: ${gameState.firstNumber} and ${gameState.secondNumber}');
                    gameNotifier.resetGame();
                  }, context),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}