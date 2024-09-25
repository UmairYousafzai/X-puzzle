import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/remote/style_card_model.dart';
import 'components/home_screen_card_design.dart';

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: new AssetImage("assets/images/background_1.jpeg"),
                fit: BoxFit.fill)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/icons/drawer_icon.png",
                      width: 50,
                      height: 40,
                    ),
                    Text(
                      "Home",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              image: AssetImage(
                                  "assets/images/place_holder_profile.png"),
                              fit: BoxFit.fill)),
                      child: Text(""),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hii, Name",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        "Let's Start",
                        style: Theme.of(context).textTheme.titleLarge!,
                      ),
                      Text(
                        "Please select the session you'd like to begin",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                HomeScreenConsumerWidget()
              ],
            ),
          ),
        ),
      ),

      // const HomeScreenConsumerWidget(),
    );
  }
}

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
    final List<StyleCardItemModel> cards = [
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

    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.73,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
          ),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return StyleCard(item: cards[index]);
          },
        ));
  }
}
