import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/colors.dart';

class SvgCircullarContainer extends StatelessWidget {
  const SvgCircullarContainer({
    super.key, required this.imagePath,
  });
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160, // Size of the circular container
      width: 160,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: MColors().brightOrange.withOpacity(0.2), // Background color of the container
      ),
      child: Center(
        child: SizedBox(
          height: 100, // Set the desired height of the image
          width: 100, // Set the desired width of the image
          child: SvgPicture.asset(
            imagePath,
            fit: BoxFit.contain, // Ensure the image fits within the specified size
          ),
        ),
      ),
    );
  }
}
