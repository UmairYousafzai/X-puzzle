import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/providers/game_number_provider.dart';
import 'package:xpuzzle/screens/widgets/buttons/buttons.dart';
import 'package:xpuzzle/theme/colors.dart';
import 'package:xpuzzle/utils/constants.dart';

class GameWidget extends ConsumerWidget {
  const GameWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedNumber = ref.watch(gameNumberProvider);

    return Container(
      width: scWidth(context) * 0.9,
      height: scHeight(context) * 0.44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: MColors().colorBeigeLight,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Cross image positioned relative to the screen size
          FractionallySizedBox(
            widthFactor: 0.5, // 50% of the container width
            child: Image.asset(
              'assets/images/purple_cross.png',
              fit: BoxFit.contain,
            ),
          ),

          // Main content (texts, buttons, etc.)
          Positioned(
            top: scHeight(context) * 0.03, // Adjust top spacing proportionally
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: scWidth(context) * 0.05),
              child: Column(
                children: [
                  Gap(scHeight(context) * 0.02),
                  Text(
                    'Enter Number',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: MColors().tealPrimary, fontSize: 18),
                  ),
                  Gap(scHeight(context) * 0.01),
                  Text(
                    'X',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: MColors().colorOrangeDark),
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
                      gameNumberButton(() {}, MColors().tealPrimary.withOpacity(0.3),
                          selectedNumber ?? '1', context, 24, false),
                      gameNumberButton(() {}, MColors().tealPrimary.withOpacity(0.3),
                          '', context, 24, false),
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
                  Gap(scHeight(context) * 0.05),
                  gameDoneButton(() {}, context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
