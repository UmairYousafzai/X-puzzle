import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/presentation/providers/question/question_usecase_provider.dart';
import 'package:xpuzzle/presentation/screens/auth/login_screen.dart';
import 'package:xpuzzle/presentation/widgets/text_widget.dart';
import 'package:xpuzzle/utils/navigation/navigate.dart';

import '../providers/auth/loginProvider.dart';
import '../providers/auth/signupProvider.dart';
import '../providers/shared_pref_provider.dart';
import '../theme/colors.dart';

class CustomNavigationDrawer extends ConsumerWidget {
  const CustomNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginNotifier = ref.read(loginProvider.notifier);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final imageHeight =
        (Platform.isIOS ? screenHeight * 0.20 : screenHeight * 0.22)
            .clamp(170.0, screenHeight * 0.4);

    // Access SharedPreferences using the provider
    final sharedPreferencesAsyncValue = ref.watch(sharedPreferencesProvider);
    final deleteDatabaseUseCase = ref.watch(deleteDatabaseUseCaseProvider);
    // final levelProviderNotifier = ref.watch(levelProvider.notifier);
    final signUpNotifier = ref.read(signUpProvider.notifier);

    return sharedPreferencesAsyncValue.when(
      data: (sharedPreferencesHelper) {
        final user = sharedPreferencesHelper.getUser();
        final userName =
            user?.firstName ?? 'John'; // Fallback to "John" if user is null

        return Drawer(
          backgroundColor: MColors().colorPrimary,
          child: Column(
            children: [
              // Top Image with Avatar and Username
              Stack(
                children: [
                  Image.asset(
                    'assets/images/navigation_drawer_top_image.png',
                    width: double.infinity,
                    height: imageHeight, // Adjusted height with clamp
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: screenHeight * 0.06,
                    left: screenWidth * 0.06,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/place_holder_profile.png",
                          width: screenWidth * 0.12,
                          height: screenWidth * 0.12,
                        ),
                        const Gap(10),
                        Text(
                          'Hi! $userName', // Display the user's name
                          style: TextStyle(
                              fontFamily: 'BalooDa2',
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // List of Rows
              Gap(screenHeight * 0.03),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    ListTile(
                      leading: SvgPicture.asset(
                        'assets/icons/svg/profile_icon.svg',
                        height: 20,
                        width: 20,
                      ),
                      title: const TextWidget(
                        text: 'Profile',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: SvgPicture.asset(
                        'assets/icons/svg/stats_icon.svg',
                        height: 20,
                        width: 20,
                      ),
                      title: const TextWidget(
                        text: 'Stats',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: SvgPicture.asset(
                        'assets/icons/svg/notifications_icon.svg',
                        height: 20,
                        width: 20,
                      ),
                      title: const TextWidget(
                        text: 'Notifications',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 30),
                child: ListTile(
                  leading: SvgPicture.asset(
                    'assets/icons/svg/logout_icon.svg',
                    height: 20,
                    width: 20,
                  ),
                  title: const TextWidget(
                    text: 'Logout',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  onTap: () async {
                    try {
                      await loginNotifier.logout();
                      signUpNotifier.resetState();
                      await deleteDatabaseUseCase.questionRepository
                          .deleteDatabase();
                      sharedPreferencesHelper.clear().then((value) {
                        navigatePushAndRemoveUntil(
                            context, const LoginScreen(), false);
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Error: $error'),
      ),
    );
  }
}
