import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xpuzzle/screens/widgets/buttons/buttons.dart';
import 'package:xpuzzle/utils/constants.dart';
import '../../providers/game_provider.dart';
import '../../theme/colors.dart';

class GameNumberButtonsWidget extends ConsumerWidget {
  const GameNumberButtonsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> numbers =
        List.generate(10, (index) => (index + 1).toString());
    final selectedNumber = ref.watch(gameProvider).selectedNumber;

    return Container(
      width: context.screenWidth * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: MColors().colorPrimary,
      ),
      child: Padding(
        padding:  EdgeInsets.all(MediaQuery.of(context).size.height > smallDeviceThreshold
            ? 20
            :  10),
        child: GridView.count(
          crossAxisCount: 5,
          mainAxisSpacing: MediaQuery.of(context).size.height > smallDeviceThreshold
              ? 10
              : 5,
          crossAxisSpacing: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: numbers.map<Widget>((number) {
            return gameNumberButton(
              () {
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
      ),
    );
  }
}
