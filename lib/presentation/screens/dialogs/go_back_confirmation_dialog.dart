import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../theme/colors.dart';
import '../../widgets/buttons/buttons.dart';

void showStyleCompletedCustomDialog(
  BuildContext context,
  void Function() onDone,
) {
  showGeneralDialog(
      context: context,
      pageBuilder: (ctx, anim1, anim2) => const SizedBox.shrink(),
      transitionBuilder: (ctx, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: anim1,
              curve: Curves.easeOutBack,
              reverseCurve: Curves.easeIn,
            ),
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27)),
              child: Container(
                height: 433.h,
                width: 334.w,
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(27),
                    color: MColors().beigeColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: SvgPicture.asset(
                              "assets/icons/svg/icon_close.svg")),
                    ),
                    80.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.r),
                      child: Text(
                        "Are you sure you want to go back?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'BalooDa2',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 21.sp),
                      ),
                    ),
                    8.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.r),
                      child: Opacity(
                        opacity: 0.6,
                        child: Text(
                          "This will result in the loss of all progress in the current level.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'BalooDa2',
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 14.sp),
                        ),
                      ),
                    ),
                    83.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      child: SizedBox(
                        width: 314.w,
                        height: 54.h,
                        child: gradientButton(context, onDone, "Done", 15),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300));
}
