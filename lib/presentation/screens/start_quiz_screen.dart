import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpuzzle/utils/constants.dart';
import '../../utils/navigation/navigate.dart';
import '../theme/colors.dart';
import 'game_screen/game_screen.dart';

class StartQuizScreen extends StatelessWidget {
  const StartQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (Platform.isIOS) {
            if (details.primaryVelocity != null &&
                details.primaryVelocity! > 0) {
              Navigator.pop(context);
              if (kDebugMode) {
                print("Left to right swipe detected");
              }
            }
          }
        },
        child: Container(
          width: context.screenWidth,
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
          decoration: BoxDecoration(
              color: MColors().beigeColor,
              image: const DecorationImage(
                  image: AssetImage(
                    "assets/images/start_game_bg.png",
                  ),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              30.verticalSpace,
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/svg/back_icon.svg",
                        width: 44.h,
                        height: 44.h,
                      )),
                ),
              ),
              50.verticalSpace,
              Text(
                "Ready to test your math skills \nto the max?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'BalooDa2',
                  fontWeight: FontWeight.w600,
                  fontSize: 19.sp,
                ),
              ),
              45.verticalSpace,
              SvgPicture.asset(
                "assets/icons/svg/rocket.svg",
                width: 142.w,
                height: 140.h,
              ),
              55.verticalSpace,
              Text(
                "Let's Test",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'BalooDa2',
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700
                ),
              ),
              Text(
                "Your Speed And Sharpness!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'BalooDa2',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600),
              ),
              84.verticalSpace,
              Text(
                "The timer starts now",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'BalooDa2',
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w500,
                    color: MColors().vividReddishPink),
              ),
              31.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 31.w),
                child: ElevatedButton(
                    onPressed: () {
                      navigatePushAndRemoveUntil(
                          context, const GameScreen(), true);
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.h, horizontal: 124.w),
                        backgroundColor: MColors().brightOrange,
                        foregroundColor: MColors().white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r))),
                    child: Center(
                      child: Text(
                        "Start",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: MColors().white,
                            fontSize: 21.sp),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
