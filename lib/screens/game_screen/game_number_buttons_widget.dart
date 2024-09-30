import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/providers/game_number_provider.dart';
import 'package:xpuzzle/screens/widgets/buttons/buttons.dart';
import 'package:xpuzzle/utils/constants.dart';
import '../../theme/colors.dart';

class GameNumberButtonsWidget extends ConsumerWidget {
  const GameNumberButtonsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // List of button labels (1 to 10)
    final List<String> numbers = List.generate(10, (index) => (index + 1).toString());
    final selecedtNumber=ref.watch(gameNumberProvider);

    return Container(
      height: context.screenHeight * 0.2,
      width: context.screenWidth * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: MColors().colorPrimary,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 5, // 5 buttons in each row
          mainAxisSpacing: 10, // Space between rows
          crossAxisSpacing: 10, // Space between columns
          shrinkWrap: true, // Let the GridView take the size of its children
          physics: const NeverScrollableScrollPhysics(), // Prevent scrolling inside the GridView
          children: numbers.map<Widget>((number) {
            return gameNumberButton(
                  () {
                    ref.read(gameNumberProvider.notifier).state=number;
                  }, // Define the onPressed callback for each button
             selecedtNumber==number? MColors().colorPrimary: MColors().white,
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
