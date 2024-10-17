import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xpuzzle/presentation/theme/colors.dart';

AppBar customAppBar(BuildContext context, String title, SvgPicture leadingIcon,
    Image? actionIcon,
    {Function()? onPressedLeading, Function()? onPressedAction}) {
  return AppBar(
    backgroundColor: MColors().white,
    title: Text(
      title,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: const Color(0xFF1E2D7C),
            fontWeight: FontWeight.w700,
          ),
    ),
    leading: IconButton(
      icon: leadingIcon,
      onPressed: onPressedLeading,
    ),
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
