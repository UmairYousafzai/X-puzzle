import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xpuzzle/screens/game_screen/game_screen.dart';
import '../../providers/home_screen_providers.dart';
import 'home_screen_card_design.dart';

class HomeScreenConsumerWidget extends ConsumerStatefulWidget {
  const HomeScreenConsumerWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return HomeScreenConsumerState();
  }
}

class HomeScreenConsumerState extends ConsumerState<HomeScreenConsumerWidget> {
  @override
  Widget build(BuildContext context) {
    final cards = ref.watch(homeScreenStylesProvider);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio:0.7,

      ),
      itemCount: cards.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => const GameScreen()));
                },
                child: StyleCard(styleItemModel: cards[index])),
          ],
        );
      },
    );
  }
}
