import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/remote/style_card_model.dart';
import 'package:flutter/material.dart';
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
  List<StyleCardItemModel> cards = [
    StyleCardItemModel(
      style: Styles.style1,
      product: "Positive product",
      sum: "Positive sum",
      styleName: "Style1",
      imageSrc: "assets/images/style.png",
    ),
    StyleCardItemModel(
      style: Styles.style2,
      product: "Positive product",
      sum: "Negative sum",
      styleName: "Style2",
      imageSrc: "assets/images/style.png",
    ),
    StyleCardItemModel(
      style: Styles.style3,
      product: "Negative product",
      sum: "Positive sum",
      styleName: "Style3",
      imageSrc: "assets/images/style.png",
    ),
    StyleCardItemModel(
      style: Styles.style4,
      product: "Negative product",
      sum: "Negative sum",
      styleName: "Style4",
      imageSrc: "assets/images/style.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.715,
      child: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: HomeScreen2CardDesign(item: cards[index]),
          );
        },
      ),
    );
  }
}
