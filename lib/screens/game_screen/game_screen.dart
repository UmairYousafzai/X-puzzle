import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/screens/game_screen/game_custom_progress_bar.dart';
import 'package:xpuzzle/screens/quiz_completion_screen.dart';
import 'package:xpuzzle/screens/widgets/buttons/buttons.dart';
import 'package:xpuzzle/theme/colors.dart';
import 'package:xpuzzle/utils/constants.dart';

import '../../providers/game_provider.dart';
import '../../providers/level_provider.dart';
import 'game_number_buttons_widget.dart';
import 'game_time_widget.dart';
import 'game_widget.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(levelProvider);
    final levelList = ref.read(levelListProvider);
    final gameState = ref.watch(gameProvider);
    final gameNotifier = ref.read(gameProvider.notifier);

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/icons/drawer_icon.png",
                    width: 50,
                    height: 40,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        level ?? 'Select Level',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: const Color(0xFF1E2D7C),
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ),
                  const Gap(50),
                ],
              ),
              Gap(context.screenHeight * 0.02),
              Row(
                children: [
                  GameTimeWidget(
                    time:
                        '${gameState.minutes.toString().padLeft(2, '0')}:${gameState.seconds.toString().padLeft(2, '0')}',
                  ),
                  const Spacer(),

                  gameState.isTimerRunning?
                  gameStartResetButton(() {                                     // Button to pause timer
                    gameNotifier.pauseTimer();
                  }, 'assets/icons/pause-button.png', MColors().colorPrimary):
                  gameStartResetButton(() {
                    gameNotifier.playTimer();                                  // Button to start timer
                  }, 'assets/images/play.png', MColors().colorPrimary)

                  ,
                  const Gap(20),
                  gameStartResetButton(() {
                    gameNotifier.resetTimer();                                  // Button to reset timer
                  }, 'assets/images/reset.png',
                      MColors().colorSecondaryBlueDark),
                ],
              ),
              Gap(context.screenHeight * 0.04),
              const CustomProgressBar(
                progress: 0.7,
              ),
              const Gap(20),
              const GameWidget(),
              const Gap(10),
              const GameNumberButtonsWidget(),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  gameBacknNextButton(context, () {
                    int currentIndex = levelList.indexOf(level!);
                    if (currentIndex > 0) {
                      ref.read(levelProvider.notifier).state =
                          levelList[currentIndex - 1];
                    } else {
                      Navigator.pop(context);
                    }
                  }, false), // Back button
                  const Gap(50),
                  gameBacknNextButton(context, () {
                    int currentIndex = levelList.indexOf(level!);
                    if (currentIndex < levelList.length - 1) {
                      ref.read(levelProvider.notifier).state =
                          levelList[currentIndex + 1];
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => QuizCompeltionScreen()));
                    }
                  }, true), // Next Button
                ],
              ),
              Gap(context.screenHeight * 0.01)
            ],
          ),
        ),
      )),
    );
  }
}
