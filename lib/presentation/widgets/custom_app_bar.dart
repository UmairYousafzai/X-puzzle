import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xpuzzle/main.dart';
import 'package:xpuzzle/presentation/theme/colors.dart';

AppBar customAppBar(
  BuildContext context,
  String title,
  SvgPicture? leadingIcon,
  Image? actionIcon, {
  Function(BuildContext)? onPressedLeading,
  Function()? onPressedAction,
  Color titleColor = Colors.black,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    title: Text(
      title,
      style: TextStyle(
        fontFamily: 'BalooDa2',
        color: titleColor,
        fontSize: 30.sp,

        fontWeight: FontWeight.w700,
      ),
    ),
    leading: Builder(builder: (BuildContext builderContext) {
      return leadingIcon != null
          ? IconButton(
              icon: leadingIcon,
              onPressed: () {
                onPressedLeading!(builderContext);
              },
            )
          : Container();
    }),
    actions: [
      actionIcon == null
          ? Container()
          : IconButton(
              icon: actionIcon,
              onPressed: onPressedAction,
            )
    ],
    centerTitle: true,
  );
}
