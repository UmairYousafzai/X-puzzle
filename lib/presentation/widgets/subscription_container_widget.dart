import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/presentation/theme/colors.dart';
import 'package:xpuzzle/presentation/widgets/buttons/buttons.dart';
import 'package:xpuzzle/utils/constants.dart';

class SubscriptionContainerWidget extends StatelessWidget {
  const SubscriptionContainerWidget(
      {super.key,
      required this.subscriptionType,
      required this.subscriptionAmount,
      required this.onPress});

  final String subscriptionType;
  final String subscriptionAmount;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight * 0.5,
      width: context.screenWidth * 0.87,
      decoration: BoxDecoration(
          color: MColors().colorPrimary,
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Container(
            height: context.screenHeight * 0.5 / 8,
            decoration: BoxDecoration(
              color: MColors().brightCyan,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), // Rounded top-left corner
                topRight: Radius.circular(16),
              ),
            ),
            child: Center(
              child: Text(
                subscriptionType,
                style: TextStyle(
                    fontFamily: 'BalooDa2',
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Gap(20.sp),
          Text(
            subscriptionAmount,
            style: TextStyle(
              fontFamily: 'BalooDa2',
              fontSize: 32.sp, // Bigger size
              color: MColors().colorSecondaryOrangeDark, // Orange color
              fontWeight: FontWeight.w700,
            ),
          ),
          Gap(10.sp),
          Text(
            "Included Features",
            style: TextStyle(
              fontFamily: 'BalooDa2',
              fontSize: 16.sp, // Bigger size
              color: Colors.black, // Orange color
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(30.sp),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.end, // Align all points to the right
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.end, // Aligning to the right
                  children: [
                    Text(
                      "1.",
                      style: TextStyle(
                        fontFamily: 'BalooDa2',
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Gap(8.sp),
                    Expanded(
                      child: Text(
                        "Unlimited access to play all levels.",
                        style: TextStyle(
                          fontFamily: 'BalooDa2',
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(10.sp),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.end, // Aligning to the right
                  children: [
                    Text(
                      "2.",
                      style: TextStyle(
                        fontFamily: 'BalooDa2',
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Gap(8.sp),
                    Expanded(
                      child: Text(
                        "The ability to print questions",
                        style: TextStyle(
                          fontFamily: 'BalooDa2',
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(10.sp),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment:
                      MainAxisAlignment.end, // Aligning to the right
                  children: [
                    Text(
                      "3.",
                      style: TextStyle(
                        fontFamily: 'BalooDa2',
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Gap(8.sp),
                    Expanded(
                      child: Text(
                        "Track and maintain a record of performance and stats while playing.",
                        style: TextStyle(
                          fontFamily: 'BalooDa2',
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Gap(30.sp),
          subscriptionButton(onPress, context, 'START FREE TRIAL')
        ],
      ),
    );
  }
}
