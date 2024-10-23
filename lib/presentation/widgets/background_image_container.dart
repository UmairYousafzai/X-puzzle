import 'package:flutter/material.dart';

class BackgroundImageContainer extends StatefulWidget {
  const BackgroundImageContainer({super.key, required this.child});

  final Widget child;

  @override
  State<BackgroundImageContainer> createState() => _BackgroundImageContainerState();
}

class _BackgroundImageContainerState extends State<BackgroundImageContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background_1.jpeg"),
                  fit: BoxFit.fill)),
          child: SafeArea(child: widget.child)),
    );
  }
}
