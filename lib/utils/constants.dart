import 'package:flutter/material.dart';

extension ScreenSize on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}



//Strings
String quizCompletedLabel="Congratulation you've Completed this Quiz!";
String playMoreQuizLabel="Let's keep testing your knowledge by playing more quizzes!";




