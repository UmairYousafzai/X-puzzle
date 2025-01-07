import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/presentation/screens/home_screen/home_screen.dart';
import 'package:xpuzzle/presentation/theme/colors.dart';
import 'package:xpuzzle/presentation/widgets/background_image_container.dart';
import 'package:xpuzzle/presentation/widgets/custom_app_bar.dart';
import 'package:xpuzzle/presentation/widgets/subscription_container_widget.dart';
import 'package:xpuzzle/utils/navigation/navigate.dart';

import '../providers/shared_pref_provider.dart';

class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var sharedPreferencesHelper = ref.read(sharedPreferencesProvider).value!;

    return BackgroundImageContainer(
        child: Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            customAppBar(context, "Subscription", null, null, fontSize: 24.sp),
            Gap(20.sp),
            Text(
              "CHOOSE YOUR PLAN",
              style: TextStyle(
                  fontFamily: 'BalooDa2',
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w600),
            ),
            Gap(10.sp),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Your ',
                    style: TextStyle(
                        fontFamily: 'BalooDa2',
                        fontSize: 14.sp, // Normal size
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text: '7-Day ',
                    style: TextStyle(
                      fontFamily: 'BalooDa2',
                      fontSize: 21.0,
                      // Bigger size
                      color: MColors().colorSecondaryOrangeDark,
                      // Orange color
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                      text: 'Free Trial Awaits!',
                      style: TextStyle(
                          fontFamily: 'BalooDa2',
                          fontSize: 14.sp, // Normal size
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            Gap(10.sp),
            SubscriptionContainerWidget(
              subscriptionType: 'Monthly',
              subscriptionAmount: '\$2.99',
              onPress: () {
                sharedPreferencesHelper
                    .saveBool("isSubscription", true)
                    .then((val) {
                  navigatePushReplacement(context, const HomeScreen());
                }); // Save to SharedPreferences
              },
            ),
            Gap(20.sp),
            SubscriptionContainerWidget(
              subscriptionType: 'Yearly',
              subscriptionAmount: '\$24.99',
              onPress: () {
                sharedPreferencesHelper
                    .saveBool("isSubscription", true)
                    .then((val) {
                  navigatePushReplacement(context, const HomeScreen());
                }); // Save to SharedPreferences
              },
            ),
            Gap(20.sp),
          ],
        ),
      ),
    ));
  }
}
