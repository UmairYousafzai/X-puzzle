import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/screens/game_screen/game_custom_progress_bar.dart';
import 'package:xpuzzle/screens/quiz_completion_screen.dart';
import 'package:xpuzzle/screens/widgets/buttons/buttons.dart';
import 'package:xpuzzle/screens/widgets/custom_app_bar.dart';
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
        appBar: customAppBar(
            context,
            level ?? 'Select Level',
            Image.asset(
              "assets/icons/drawer_icon.png",
              width: 50,
              height: 40,
            ),
            () {}),
        body: Padding(
          padding: EdgeInsets.all(
              MediaQuery.of(context).size.height > smallDeviceThreshold
                  ? 10
                  : 5),
          child: Column(
            children: [
              Gap(context.screenHeight * 0.02),
              Row(
                children: [
                  GameTimeWidget(
                    time:
                        '${gameState.minutes.toString().padLeft(2, '0')}:${gameState.seconds.toString().padLeft(2, '0')}',
                  ),
                  const Spacer(),
                  gameState.isTimerRunning
                      ? gameStartResetButton(context,() {
                          // Button to pause timer
                          gameNotifier.pauseTimer();
                        }, 'assets/icons/pause-button.png',
                          MColors().colorPrimary)
                      : gameStartResetButton(context,() {
                          gameNotifier.playTimer(); // Button to start timer
                        }, 'assets/images/play.png', MColors().colorPrimary),
                  Gap(MediaQuery.of(context).size.height > smallDeviceThreshold
                      ? 20
                      : 10),
                  gameStartResetButton(context,() {
                    gameNotifier.resetTimer(); // Button to reset timer
                  }, 'assets/images/reset.png',
                      MColors().colorSecondaryBlueDark),
                ],
              ),
              Gap(
                  MediaQuery.of(context).size.height > smallDeviceThreshold
                      ? context.screenHeight * 0.04
                      : context.screenHeight * 0.02
                  ),
              const CustomProgressBar(
                progress: 0.7,
              ),
               Gap(
                  MediaQuery.of(context).size.height > smallDeviceThreshold
                      ? 20
                      : 10),
              const GameWidget(),
               Gap(MediaQuery.of(context).size.height > smallDeviceThreshold
                  ? 10
                  : 5),
              const GameNumberButtonsWidget(),
               Gap(MediaQuery.of(context).size.height > smallDeviceThreshold
                  ? 10
                  : 5),
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
                   Gap(MediaQuery.of(context).size.height > smallDeviceThreshold
                      ? 50
                      : 25),
                  gameBacknNextButton(context, () {
                    int currentIndex = levelList.indexOf(level!);
                    if (currentIndex < levelList.length - 1) {
                      ref.read(levelProvider.notifier).state =
                          levelList[currentIndex + 1];
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => QuizCompletionScreen()));
                    }
                  }, true), // Next Button
                ],
              ),
              Gap(context.screenHeight * 0.01)
            ],
          ),
        ));
  }
}
