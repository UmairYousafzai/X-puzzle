import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xpuzzle/presentation/theme/colors.dart';

AppBar customAppBar(
  BuildContext context,
  String title,
  SvgPicture? leadingIcon,
  Image? actionIcon, {
  Function()? onPressedLeading,
  Function()? onPressedAction,
  Color titleColor =  Colors.black,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    title: Text(
      title,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: titleColor,
            fontWeight: FontWeight.w700,
          ),
    ),
    leading: leadingIcon != null? IconButton(
      icon: leadingIcon,
      onPressed: onPressedLeading,
    ): Container(),
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
