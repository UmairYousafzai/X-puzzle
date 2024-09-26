import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackgroundImageContainer extends StatelessWidget {
  BackgroundImageContainer({super.key, required this.widget});

  Widget widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: new AssetImage("assets/images/background_1.jpeg"),
                  fit: BoxFit.fill)),
          child: SafeArea(child: widget)),
    );
  }
}
