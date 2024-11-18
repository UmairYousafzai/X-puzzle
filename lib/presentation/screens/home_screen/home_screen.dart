import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xpuzzle/presentation/providers/level_provider.dart';
import 'package:xpuzzle/presentation/providers/shared_pref_provider.dart';
import 'package:xpuzzle/presentation/screens/select_level_screen.dart';
import 'package:xpuzzle/presentation/widgets/custom_app_bar.dart';
import 'package:xpuzzle/presentation/widgets/custom_drawer.dart';
import 'package:xpuzzle/utils/constants.dart';
import '../../providers/home_screen_providers.dart';
import '../../widgets/level_with_background.dart';
import 'home_screen_list_view.dart';
import 'home_screen_grid_view.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenState = ref.watch(homeViewTypeProvider);
    final viewNotifier = ref.read(homeViewTypeProvider.notifier);
    final levels = ref.watch(levelProvider);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    // Access SharedPreferences using the provider
    final sharedPreferencesAsyncValue = ref.watch(sharedPreferencesProvider);

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (kDebugMode) {
          print("canPop===========> $didPop");
        }

        ref.watch(homeViewTypeProvider.notifier).setLoading(false);
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => const SelectLevelScreen()));
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const CustomDrawer(),
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
                  customAppBar(
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
                      onPressedLeading: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      onPressedAction: () {}),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sharedPreferencesAsyncValue.when(
                          data: (sharedPreferencesHelper) {
                            final user = sharedPreferencesHelper.getUser();
                            final userName = '${user?.firstName ?? 'User'} ${user?.lastName ?? ''}'.trim();
                            // Fallback to "User" if null
                            return Text(
                              "Hi, $userName",
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontSize: 18,
                              ),
                            );
                          },
                          loading: () => const CircularProgressIndicator(), // Show loading indicator
                          error: (error, stack) => Text(
                            'Error: $error',
                            style: const TextStyle(color: Colors.red),
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
                                icon: Icon(screenState["view_type"] == ViewType.list
                                    ? Icons.grid_view
                                    : Icons.list))
                          ],
                        ),
                        Text(
                          "Please select the session you'd \nlike to begin",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                              fontSize: context.screenHeight * 0.021),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  levels.when(data: (data) {
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 0, 18),
                        child: levelWithBackground(data ?? ""));
                  }, error: (err, stack) {
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 0, 18),
                        child: levelWithBackground(""));
                  }, loading: () {
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 0, 18),
                        child: levelWithBackground(""));
                  }),
                  screenState["view_type"] == ViewType.list
                      ? const Expanded(child: HomeScreenGridView())
                      : const Expanded(child: HomeScreenListView()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
