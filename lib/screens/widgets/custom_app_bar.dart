import 'package:flutter/material.dart';

AppBar customAppBar(BuildContext context, String title, Image leadingIcon,
    Function() onPressed) {
  return AppBar(
    title: Text(
      title,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: const Color(0xFF1E2D7C),
            fontWeight: FontWeight.w700,
          ),
    ),
    leading: IconButton(
      icon: leadingIcon,
      onPressed: onPressed,
    ),
    centerTitle: true,
  );
}
