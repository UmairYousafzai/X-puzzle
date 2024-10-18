import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xpuzzle/presentation/widgets/custom_app_bar.dart';

import '../../providers/home_screen_providers.dart';
import 'home_screen2_stateful.dart';
import 'home_screen_stateful.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenState = ref.watch(homeViewTypeProvider);
    final viewNotifier = ref.read(homeViewTypeProvider.notifier);
    return PopScope(
      onPopInvoked: (canPop) {
        ref.watch(homeViewTypeProvider.notifier).setLoading(false);
      },
      child: Scaffold(
        appBar: customAppBar(
            context,
            "Home",
            SvgPicture.asset(
              "assets/icons/svg/hamburger_menu_icon.svg",
              width: 40,
              height: 25,
            ),
            Image.asset(
              "assets/images/place_holder_profile.png",
              width: 50,
              height: 50,
            ),
            onPressedLeading: () {},
            onPressedAction: () {}),
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi, Name",
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontSize: 20,
                                  ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Let's Start",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                            IconButton(
                                onPressed: () {
                                  viewNotifier.toggleView();
                                },
                                icon: Icon(
                                    screenState["view_type"] == ViewType.list
                                        ? Icons.grid_view
                                        : Icons.list))
                          ],
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
                  screenState["view_type"] == ViewType.list
                      ? const Expanded(child: HomeScreenConsumerWidget())
                      : const Expanded(child: HomeScreen2ConsumerWidget()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
