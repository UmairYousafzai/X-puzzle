import 'package:flutter/material.dart';

class CustomBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // The "Correct Answer" label on top of the container
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          decoration:const  BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
          ),
          child: const Text(
            'Correct Answer',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Main Trapezoid Container (with Level 4, 12/8, and Style 1)
        Container(
          height: 50,

          child: CustomPaint(
            painter: MainTrapezoidPainter(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Left side: Level 4
                  const Text(
                    'Level 4',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Center Trapezoid for "12/8"
                   Container(
                    width: 130,
                    child: CustomPaint(
                      painter: TrapezoidPainter(),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            '12/8',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Right side: Style 1
                  Text(
                    'Style 1',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Custom painter to draw the trapezoid main container
class MainTrapezoidPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.lightBlueAccent.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    var path = Path();
    // Drawing trapezoid shape for the main container
    path.moveTo(size.width * 0.05, 0); // Top-left corner (shorter)
    path.lineTo(size.width * 0.95, 0); // Top-right corner (shorter)
    path.lineTo(size.width, size.height); // Bottom-right (wider)
    path.lineTo(0, size.height); // Bottom-left (wider)
    path.close(); // Complete the trapezoid

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Custom painter to draw the smaller center trapezoid for "12/8"
class TrapezoidPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.blue[900]!
      ..style = PaintingStyle.fill;

    var path = Path();
    // Drawing trapezoid shape for the "12/8" container
    path.moveTo(0, 0); // Top-left corner
    path.lineTo(size.width, 0); // Top-right corner
    path.lineTo(size.width * 0.85, size.height); // Bottom-right (narrower)
    path.lineTo(size.width * 0.15, size.height); // Bottom-left (narrower)
    path.close(); // Complete the trapezoid

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}