import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class GameTimeWidget extends StatelessWidget {
  const GameTimeWidget({super.key, required this.time});

  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height > smallDeviceThreshold
              ? 10
              : 5,
          horizontal: 35),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF3), // #FFFBF3
        border: Border.all(
          color: const Color(0x800CD4F8), // #0CD4F8 with 50% opacity
          width: 1, // You can adjust the border width as needed
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        time,
        style: const TextStyle(fontSize: 14, color: Colors.black),
      ),
    );
  }
}
