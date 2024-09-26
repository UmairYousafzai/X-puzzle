import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/screens/widgets/background_image_container.dart';
import 'package:xpuzzle/screens/widgets/dropdown_field_widget.dart';
import 'package:xpuzzle/screens/widgets/primaryButton.dart';
import 'package:xpuzzle/utils/constants.dart';


class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundImageContainer(
        widget: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gap(scHeight(context) * 0.1),
          Image.asset(
            'assets/logos/X-Puzzles-logo.png',
          ),
          const Gap(18),
          Text("Welcome to the X puzzle",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF1E2D7C),
                  fontWeight: FontWeight.w700,
                  fontSize: 22)),
          Gap(scHeight(context) * 0.13),
          DropdownFieldWidget(),
          Gap(scHeight(context) * 0.04),
          Primarybutton(onPressed: (){}, text: 'Continue')
        ],
      ),
    ));
  }
}
