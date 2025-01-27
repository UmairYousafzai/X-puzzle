import 'package:flutter/material.dart';

class BackgroundImageContainer extends StatefulWidget {
  const BackgroundImageContainer({super.key, required this.child, this.showAppBar});

  final Widget child;
  final bool? showAppBar;

  @override
  State<BackgroundImageContainer> createState() => _BackgroundImageContainerState();
}

class _BackgroundImageContainerState extends State<BackgroundImageContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:true,
      appBar: widget.showAppBar != false
          ? AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        elevation: 0,
      )
          : null,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_1.jpeg"),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(child: widget.child),
      ),
    );
  }
}
