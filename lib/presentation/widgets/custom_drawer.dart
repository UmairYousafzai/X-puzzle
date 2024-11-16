import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/presentation/screens/user_details_screen.dart';
import 'package:xpuzzle/presentation/widgets/text_widget.dart';
import '../theme/colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final imageHeight = (Platform.isIOS ? screenHeight * 0.20 : screenHeight * 0.22).clamp(170.0, screenHeight * 0.4);

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
                      'Hi! John',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: screenWidth * 0.05, fontWeight: FontWeight.w400),
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
                  leading: Image.asset(
                    'assets/icons/profile_icon.png',
                    height: 20,
                    width: 20,
                  ),
                  title: const TextWidget(
                    text: 'Profile',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const UserDetailsScreen()));
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/icons/stats_icon.png',
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
                  leading: Image.asset(
                    'assets/icons/notification_icon.png',
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
              leading: Image.asset(
                'assets/icons/logout_icon.png',
                height: 20,
                width: 20,
              ),
              title: const TextWidget(
                text: 'Logout',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
