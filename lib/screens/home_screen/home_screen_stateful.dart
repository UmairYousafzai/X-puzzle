import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/remote/style_card_model.dart';
import 'package:flutter/material.dart';

import 'home_screen_card_design.dart';

class HomeScreenConsumerWidget extends ConsumerStatefulWidget {
  const HomeScreenConsumerWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return HomeScreenConsumerState();
  }
}

class HomeScreenConsumerState extends ConsumerState<HomeScreenConsumerWidget> {
  List<StyleCardItemModel> cards = [
    StyleCardItemModel(
        style: Styles.style1,
        product: "Positive product",
        sum: "Positive sum",
        styleName: "Style1",
        imageSrc: "assets/images/style_1.png"),
    StyleCardItemModel(
        style: Styles.style2,
        product: "Positive product",
        sum: "Negative sum",
        styleName: "Style2",
        imageSrc: "assets/images/style_2.png"),
    StyleCardItemModel(
        style: Styles.style3,
        product: "Negative product",
        sum: "Positive sum",
        styleName: "Style3",
        imageSrc: "assets/images/style_3.png"),
    StyleCardItemModel(
        style: Styles.style4,
        product: "Negative product",
        sum: "Negative sum",
        styleName: "Style4",
        imageSrc: "assets/images/style_4.png")
  ];

  @override
  Widget build(BuildContext context) {

    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.715,
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
