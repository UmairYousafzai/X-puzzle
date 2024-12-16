import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xpuzzle/main.dart';
import 'package:xpuzzle/utils/constants.dart';
import '../../data/models/remote/style_card_model.dart';

class LevelsHeader extends StatelessWidget {
  final String level;
  final String style;
  final int totalQuestions;
  final int correct;

  const LevelsHeader(
      {super.key,
      required this.level,
      required this.totalQuestions,
      required this.style,
      required this.correct});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: SvgPicture.asset(
              "assets/images/svgs/header_background_complete.svg",
              width: context.screenWidth.w,
            )),
        Padding(
          padding: EdgeInsets.only(left: 40.h, right: 40.h, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 0.w),
                child: Text(
                  level,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.h),
                child: Text(
                  "$totalQuestions/$correct",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.w),
                child: Text(
                  style,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
