import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/providers/level_provider.dart';
import 'package:xpuzzle/utils/constants.dart';
import '../../theme/colors.dart';
import '../widgets/buttons/buttons.dart';
import 'home_screen2_stateful.dart';
import 'home_screen_stateful.dart';


class HomeScreen2 extends ConsumerWidget {
  const HomeScreen2({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final level=ref.read(levelProvider);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background_1.jpeg"),
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
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),
                      ),
                       Text(
                        "Please select the session you'd like to begin",
                        style: TextStyle(color: MColors().grey),
                      ),
                      const Gap(20),
                      levelButton(() {}, level!,context)
                    ],
                  ),
                ),
                Gap(context.screenHeight *0.02),

               const Expanded(child: HomeScreen2ConsumerWidget())
              ],
            ),
          ),
        ),
      ),

      // const HomeScreenConsumerWidget(),
    );
  }
}

