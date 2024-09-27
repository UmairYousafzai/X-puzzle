import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/screens/widgets/buttons/buttons.dart';
import 'package:xpuzzle/screens/game_screen/game_custom_progress_bar.dart';
import 'package:xpuzzle/theme/colors.dart';
import 'package:xpuzzle/utils/constants.dart';

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
                        level??'Select Level',
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
              Gap(scHeight(context) * 0.02),
              Row(
                children: [
                  const GameTimeWidget(
                    time: '04:25',
                  ),
                  const Spacer(),
                  gameStartResetButton(() {}, 'assets/images/play.png',
                      MColors().colorBeigeLight),
                  const Gap(20),
                  gameStartResetButton(
                      () {}, 'assets/images/reset.png', MColors().tealPrimary),
                ],
              ),
              Gap(scHeight(context) * 0.04),
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
                    }
                    else{
                    }
                  }, true), // Next Button
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
