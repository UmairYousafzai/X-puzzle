import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xpuzzle/utils/constants.dart';
import '../../providers/game_provider.dart';
import '../../theme/colors.dart';
import '../../widgets/buttons/buttons.dart';

class GameNumberButtonsWidget extends ConsumerWidget {
  const GameNumberButtonsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> numbers =
        List.generate(10, (index) => (index + 1).toString());
    final selectedNumber = ref.watch(gameProvider).selectedNumber;
    final gameState = ref.watch(gameProvider);

    double paddingValueTop =
        MediaQuery.of(context).size.height > smallDeviceThreshold ? 35 : 17.5;
    double paddingValueHorizontal =
        MediaQuery.of(context).size.height > smallDeviceThreshold ? 25 : 12;
    return Container(
      padding: EdgeInsets.only(
          left: paddingValueHorizontal,
          right: paddingValueHorizontal,
          top: paddingValueTop),
      width: context.screenWidth * 0.9,
      height: context.screenHeight * 0.2,
      // Adjust the height to show only 2 rows

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: MColors().colorPrimary,
      ),
      child: GridView.count(
        crossAxisCount: 5,
        mainAxisSpacing:
            MediaQuery.of(context).size.height > smallDeviceThreshold ? 10 : 5,
        crossAxisSpacing: 20,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: numbers.map<Widget>((number) {
          return gameNumberButton(
            () {
              if (gameState.firstNumberFocus.hasFocus &&
                  gameState.firstNumber.length < 4) {
                ref
                    .read(gameProvider.notifier)
                    .updateFirstNumber(gameState.firstNumber + number);
              } else if (gameState.secondNumberFocus.hasFocus &&
                  gameState.secondNumber.length < 4) {
                ref
                    .read(gameProvider.notifier)
                    .updateSecondNumber(gameState.secondNumber + number);
              }
              ref.read(gameProvider.notifier).updateSelectedNumber(number);
            },
            selectedNumber == number
                ? MColors().colorSecondaryBlueDark
                : MColors().white,
            number,
            context,
            15,
            true,
          );
        }).toList(), // Convert Iterable to List<Widget>
      ),
    );
  }
}
