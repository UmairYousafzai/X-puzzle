import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/presentation/widgets/snackBar_messages.dart';
import 'package:xpuzzle/utils/constants.dart';
import '../providers/level_provider.dart';
import '../widgets/background_image_container.dart';
import '../widgets/buttons/buttons.dart';
import '../widgets/custom_fields/dropdown_field_widget.dart';
import 'home_screen/home_screen.dart';

class SelectLevelScreen extends ConsumerStatefulWidget {
  const SelectLevelScreen({super.key});

  @override
  ConsumerState<SelectLevelScreen> createState() => _SelectLevelScreenState();
}

class _SelectLevelScreenState extends ConsumerState<SelectLevelScreen> {
  String selectedValue = "";

  @override
  Widget build(BuildContext context) {
    return BackgroundImageContainer(
        child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gap(context.screenHeight * 0.1),
          Image.asset(
            'assets/logos/X-Puzzles-logo.png',
          ),
          const Gap(18),
          Text("Welcome to the X puzzle",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF1E2D7C),
                  fontWeight: FontWeight.w700,
                  fontSize: 22)),
          Gap(context.screenHeight * 0.13),
          DropdownFieldWidget(
            onChanged: (value) async {
              // Update the selected value using RiverPod
              if (kDebugMode) {
                print("level changed value==============> $value");
              }
              selectedValue = value ?? "";
            },
          ),
          Gap(context.screenHeight * 0.04),
          primaryButton(() {
            if (selectedValue.isNotEmpty) {
              ref.read(levelProvider.notifier).updateLevel(selectedValue);
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const HomeScreen()));
            }else{
              showErrorSnackBar(context, "Please select level");
            }


          }, 'Continue', Colors.black, context)
        ],
      ),
    ));
  }
}
