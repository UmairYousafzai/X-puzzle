import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/utils/constants.dart';

import '../../../theme/colors.dart';

levelButton(VoidCallback onPress, String level, BuildContext context) {
  return InkWell(
    onTap: onPress,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFF78C0C).withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Text(level,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: MColors().colorOrangeDark, fontSize: 14)),
      ),
    ),
  );
}

startButton(VoidCallback onPress, BuildContext context) {
  return InkWell(
    onTap: onPress,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF38E8F3), Color(0xFF09D3F8)])),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
        child: Text('Start',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: MColors().white, fontSize: 14)),
      ),
    ),
  );
}

primaryButton(VoidCallback onPressed, String text) {
  return Container(
    height: 54,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xFF38E8F3),
          Color(0xFF09D3F8),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(15),
    ),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        minimumSize: const Size(double.infinity, 40),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black),
      ),
    ),
  );
}

gameStartResetButton(
    VoidCallback onPressed, String image, Color backgroundColor) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor,
        border: Border.all(
          color: const Color(0x800CD4F8), // #0CD4F8 with 50% opacity
          width: 1, // You can adjust the border width as needed
        ),
      ),
      child: Image.asset(image),
    ),
  );
}

gameNumberButton(VoidCallback onPressed, Color backgroundColor, String text,
    BuildContext context, double fontSize, bool black) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      height: scHeight(context) * 0.06,
      width: scHeight(context) * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: backgroundColor,
        border: Border.all(
          color: const Color(0x800CD4F8), // #0CD4F8 with 50% opacity
          width: 1, // You can adjust the border width as needed
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: black ? Colors.black : MColors().tealPrimary,
              fontSize: fontSize),
        ),
      ),
    ),
  );
}

gameDoneButton(VoidCallback onPressed, BuildContext context) {
  return Container(
    // padding: EdgeInsets.symmetric(vertical: scHeight(context)*0.02, horizontal:70),
    decoration: BoxDecoration(
      color: MColors().colorBeigeLight, // #FFFBF3
      border: Border.all(
        color: MColors().colorOrangeDark, // #0CD4F8 with 50% opacity
        width: 1, // You can adjust the border width as needed
      ),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 12),
      child: Text(
        'Mark Done',
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: MColors().colorOrangeDark, fontSize: 13),
      ),
    ),
  );
}

gameBacknNextButton(BuildContext context,VoidCallback onPressed, bool isNext) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      padding: EdgeInsets.symmetric(
        vertical: 7,
        horizontal: scWidth(context) * 0.04,
      ),
      decoration: BoxDecoration(
        color: MColors().colorBeigeLight, // #FFFBF3
        gradient: const LinearGradient(colors: [
          Color(0xFF38E8F3),
          Color(0xFF09D3F8),
        ]),
        borderRadius: BorderRadius.circular(30),
      ),
      child: isNext? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min, // Adjust the size to the content
        children: [
           Text(
            'Next', // The text inside the button
            style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          const Gap(15),
          // Gap between the text and the arrow icon
          Container(
            padding: const EdgeInsets.all(8), // Padding for the icon
            decoration: const BoxDecoration(
                shape: BoxShape.circle, // Circular background for the icon
                color: Colors.yellow,
                gradient:
                    LinearGradient(colors: [Color(0xFFFBDF0D),Color(0xFFF78F0C), ])
                // Yellow background color
                ),
            child: const Icon(
              Icons.arrow_forward, // Arrow icon pointing forward
              color: Colors.white, // Icon color
              size: 18, // Icon size
            ),
          ),

        ],
      )
:
      Row(
        mainAxisSize: MainAxisSize.min, // Adjust the size to the content
        children: [

          // Gap between the text and the arrow icon
          Container(
            padding: const EdgeInsets.all(8), // Padding for the icon
            decoration: const BoxDecoration(
                shape: BoxShape.circle, // Circular background for the icon
                color: Colors.yellow,
                gradient:
                LinearGradient(colors: [Color(0xFFFBDF0D),Color(0xFFF78F0C), ])
              // Yellow background color
            ),
            child: const Icon(
              Icons.arrow_back, // Arrow icon pointing forward
              color: Colors.white, // Icon color
              size: 18, // Icon size
            ),
          ),
          const Gap(15),
              Text(
            'Back', // The text inside the button
            style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
          ),

        ],
      ),
    ),
  );
}
