import 'package:flutter/material.dart';

import 'home_screen_stateful.dart';


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
                      child: const Text(""),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hii, Name",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "Let's Start",
                        style: Theme.of(context).textTheme.titleLarge!,
                      ),
                      const Text(
                        "Please select the session you'd like to begin",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                const HomeScreenConsumerWidget()
              ],
            ),
          ),
        ),
      ),

      // const HomeScreenConsumerWidget(),
    );
  }
}

