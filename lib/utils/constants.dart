import 'package:flutter/material.dart';

extension ScreenSize on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}

//UI
int smallDeviceThreshold = 700;
int largeDeviceThreshold = 800;




//Strings
String quizCompletedLabel="Congratulations you’ve\nCompleted this Quiz!";
String playMoreQuizLabel="Let's keep testing your knowledge by playing more quizzes!";




