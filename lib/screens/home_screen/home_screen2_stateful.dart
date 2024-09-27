import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xpuzzle/providers/home_screen_providers.dart';
import '../../../models/remote/style_card_model.dart';
import 'package:flutter/material.dart';
import '../game_screen/game_screen.dart';
import 'home_screen2_card_design.dart';
import 'home_screen_card_design.dart';

class HomeScreen2ConsumerWidget extends ConsumerStatefulWidget {
  const HomeScreen2ConsumerWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return HomeScreen2ConsumerState();
  }
}

class HomeScreen2ConsumerState extends ConsumerState<HomeScreen2ConsumerWidget> {

  @override
  Widget build(BuildContext context) {
    final cards=ref.watch(homeScreenStylesProvider);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.715,
      child: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) =>  GameScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: HomeScreen2CardDesign(item: cards[index]),
            ),
          );
        },
      ),
    );
  }
}
