import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/presentation/providers/subscription_provider/sub_screen_providers.dart';
import 'package:xpuzzle/presentation/screens/home_screen/home_screen.dart';
import 'package:xpuzzle/presentation/theme/colors.dart';
import 'package:xpuzzle/presentation/widgets/background_image_container.dart';
import 'package:xpuzzle/presentation/widgets/custom_app_bar.dart';
import 'package:xpuzzle/presentation/widgets/subscription_container_widget.dart';
import 'package:xpuzzle/utils/navigation/navigate.dart';

import '../providers/shared_pref_provider.dart';

class SubscriptionScreen extends ConsumerStatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SubscriptionScreenState();
  }
}

class _SubscriptionScreenState extends ConsumerState<SubscriptionScreen> {
  @override
  void initState() {
    super.initState();
    Future(() {
      ref.watch(subScreenProvider.notifier).getSubProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    var sharedPreferencesHelper = ref.read(sharedPreferencesProvider).value!;
    var subscriptionProvider = ref.read(subScreenProvider);
    var subscriptionNotifier = ref.watch(subScreenProvider.notifier);

    return BackgroundImageContainer(
        child: Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            customAppBar(context, "Subscription", null, null, fontSize: 24.sp),
            20.verticalSpace,
            Text(
              "CHOOSE YOUR PLAN",
              style: TextStyle(
                  fontFamily: 'BalooDa2',
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w600),
            ),
            10.verticalSpace,
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
            10.verticalSpace,
            for (var product in subscriptionProvider.products)
              SubscriptionContainerWidget(
                subscriptionType: product.title,
                subscriptionAmount:
                    "${product.currencySymbol} ${product.price}",
                onPress: () {
                  sharedPreferencesHelper
                      .saveBool("isSubscription", true)
                      .then((val) {
                    navigatePushReplacement(context, const HomeScreen());
                  }); // Save to SharedPreferences
                },
              ),
            //
            // SubscriptionContainerWidget(
            //   subscriptionType: 'Yearly',
            //   subscriptionAmount: '\$24.99',
            //   onPress: () {
            //     sharedPreferencesHelper
            //         .saveBool("isSubscription", true)
            //         .then((val) {
            //       navigatePushReplacement(context, const HomeScreen());
            //     }); // Save to SharedPreferences
            //   },
            // ),
            20.verticalSpace,
          ],
        ),
      ),
    ));
  }
}
