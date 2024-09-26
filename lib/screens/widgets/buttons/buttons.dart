import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

levelButton(VoidCallback onPress, String level, BuildContext context) {
  return InkWell(
    onTap: onPress,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFF78C0C).withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Text(level,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: MColors().colorSecondaryOrangeDark, fontSize: 14)),
      ),
    ),
  );
}

startButton(VoidCallback onPress, BuildContext context) {
  return InkWell(
    onTap: onPress,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [ Color(0xFF38E8F3),Color(0xFF09D3F8)])),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
        child: Text('Start',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: MColors().white, fontSize: 14)),
      ),
    ),
  );
}



primaryButton(VoidCallback onPress, String text){
  return Container(
    height: 54,
    decoration: BoxDecoration(

      gradient: const LinearGradient(
        colors: [
          Color(0xFF38E8F3),
          Color(0xFF09D3F8),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(15),
    ),
    child: ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        minimumSize: const Size(double.infinity, 40),
      ),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.black),
      ),
    ),
  );


}