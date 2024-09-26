import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

import '../../providers/home_screen_providers.dart';
import '../widgets/home_screen_card_design.dart';

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
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height * 0.715,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
        ),
        itemCount: cards.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              StyleCard(item: cards[index]),
            ],
          );
        },
      ),
    );
  }
}
