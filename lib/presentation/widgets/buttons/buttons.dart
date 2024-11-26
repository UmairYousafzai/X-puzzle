import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpuzzle/main.dart';
import 'package:xpuzzle/utils/constants.dart';

import '../../theme/colors.dart';

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
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: MColors().colorSecondaryOrangeDark, fontSize: 14)),
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
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        child: Text('Start',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: MColors().white, fontSize: 14)),
      ),
    ),
  );
}

primaryButton(VoidCallback onPressed, String text, Color textColor,
    BuildContext context) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: double.infinity,
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
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
              fontWeight: FontWeight.w500, fontSize: 18, color: textColor),
        ),
      ),
    ),
  );
}

gameStartResetButton(BuildContext context, VoidCallback onPressed, String image,
    Color backgroundColor) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      padding: EdgeInsets.all(
          MediaQuery.of(context).size.height > smallDeviceThreshold ? 12 : 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor,
        border: Border.all(
          color: const Color(0x800CD4F8), // #0CD4F8 with 50% opacity
          width: 1, // You can adjust the border width as needed
        ),
      ),
      child: SvgPicture.asset(
        image,
        width: 20,
      ),
    ),
  );
}

gameNumberButton(VoidCallback onPressed, Color backgroundColor, String text,
    BuildContext context, double fontSize, bool black) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      height: MediaQuery.of(context).size.height > smallDeviceThreshold
          ? context.screenHeight * 0.06
          : context.screenHeight * 0.01,
      width: context.screenWidth * 0.1,
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
              color: black ? Colors.black : MColors().colorSecondaryBlueDark,
              fontSize:
                  MediaQuery.of(context).size.height > smallDeviceThreshold
                      ? fontSize
                      : fontSize - 2),
        ),
      ),
    ),
  );
}

gameDoneButton(VoidCallback onPressed, BuildContext context, String title,
    {double borderRadius = 30, double paddingHorizontal =70,double? fontSize,}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      // padding: EdgeInsets.symmetric(vertical: scHeight(context)*0.02, horizontal:70),
      decoration: BoxDecoration(
        color: MColors().colorPrimary, // #FFFBF3
        border: Border.all(
          color: MColors().colorSecondaryOrangeDark, // #0CD4F8 with 50% opacity
          width: 1, // You can adjust the border width as needed
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal:  paddingHorizontal.r,
            vertical:14.r),
        child: Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 1,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: MColors().colorSecondaryOrangeDark,
              fontSize: fontSize??15.32),
        ),
      ),
    ),
  );
}

gameBacknNextButton(
    BuildContext context, VoidCallback onPressed, bool isNext, bool isActive) {
  return GestureDetector(
    onTap: isActive ? onPressed : null,
    child: Opacity(
      opacity: isActive ? 1.0 : 0.33,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical:
              MediaQuery.of(context).size.height > smallDeviceThreshold ? 7 : 3,
          horizontal: context.screenWidth * 0.04,
        ),
        decoration: BoxDecoration(
          color: MColors().colorPrimary, // #FFFBF3
          gradient: const LinearGradient(colors: [
            Color(0xFF38E8F3),
            Color(0xFF09D3F8),
          ]),
          borderRadius: BorderRadius.circular(30),
        ),
        child: isNext
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize:
                    MainAxisSize.min, // Adjust the size to the content
                children: [
                  Text(
                    'Next', // The text inside the button
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const Gap(15),
                  // Gap between the text and the arrow icon
                  Container(
                    padding: const EdgeInsets.all(8), // Padding for the icon
                    decoration: const BoxDecoration(
                        shape:
                            BoxShape.circle, // Circular background for the icon
                        color: Colors.yellow,
                        gradient: LinearGradient(colors: [
                          Color(0xFFFBDF0D),
                          Color(0xFFF78F0C),
                        ])
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
            : Row(
                mainAxisSize:
                    MainAxisSize.min, // Adjust the size to the content
                children: [
                  // Gap between the text and the arrow icon
                  Container(
                    padding: const EdgeInsets.all(8), // Padding for the icon
                    decoration: const BoxDecoration(
                        shape:
                            BoxShape.circle, // Circular background for the icon
                        color: Colors.yellow,
                        gradient: LinearGradient(colors: [
                          Color(0xFFFBDF0D),
                          Color(0xFFF78F0C),
                        ])
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
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
      ),
    ),
  );
}

gradientButton(BuildContext context, VoidCallback onPressed, String title,
    double borderRadius) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height > smallDeviceThreshold
              ? 15
              : 10,
          horizontal: context.screenWidth * 0.1,
        ),
        decoration: BoxDecoration(
          color: MColors().colorPrimary, // #FFFBF3
          gradient: const LinearGradient(colors: [
            Color(0xFF38E8F3),
            Color(0xFF09D3F8),
          ]),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        )),
  );
}

viewCompleteResultsButton(VoidCallback onPressed, BuildContext context) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: MColors().colorSecondaryOrangeDark),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          'View Complete Results',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: MColors().colorSecondaryOrangeDark),
        ),
      ),
    ),
  );
}
