import 'package:flutter/material.dart';
import 'package:xpuzzle/presentation/screens/dialogs/style_completed_custom_dialog.dart';

import '../../theme/colors.dart';

class CustomProgressBar extends StatelessWidget {
  final double progress; // Value between 0 and 1

  const CustomProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 6, //
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // Rounded corners for the track
         color: MColors().beigeColor
        ),
        child: Stack(
          children: [
            Container(

              // Background container for the track
              decoration: BoxDecoration(
                color: MColors().beigeColor, // Track background color
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                 gradient: LinearGradient(colors: [MColors().brightCyan,MColors().vividSkyBlue,])
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
