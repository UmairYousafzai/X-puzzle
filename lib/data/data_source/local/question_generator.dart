import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:xpuzzle/domain/entities/question.dart';

List<Question> generatePositiveMultipleAndPositiveInteger({
  int numberOfQuestion = 0,
  bool isPPAndPS = false,
  bool isPPAndNS = false,
  bool isNPAndPS = false,
  bool isNPAndNS = false,
}) {
  List<Question> questions = [];
  for (int i = 0; i < numberOfQuestion; i++) {
    int left = 0;
    int right = 0;
    if (isPPAndPS) {
      left = Random().nextInt(20) + 1;
      right = Random().nextInt(20) + 1;
    } else if (isPPAndNS) {
      left = -(Random().nextInt(20) + 1);
      right = -Random().nextInt(20) + 1;
    } else if (isNPAndPS) {
      left = Random().nextInt(19) + 2;
      right = -(Random().nextInt(left - 1) + 1);
    } else if (isNPAndNS) {
      left = Random().nextInt(10) + 1;
      right = -(Random().nextInt(10) + left + 1);
    }

    final sum = left + right;
    final product = left * right;

    questions.add(Question(
      id: null,
      numOne: left.toString(),
      numTwo: right.toString(),
      inputNumOne: "",
      inputNumTwo: "",
      topNum: product.toString(),
      bottomNum: sum.toString(),
      isComplete: false,
      isCorrect: false,
      isPPAndPS: isPPAndPS,
      isPPAndNS: isPPAndNS,
      isNPAndPS: isNPAndPS,
      isNPAndNS: isNPAndNS,
    ));
  }
  if (kDebugMode) {
    print("generated question values==============> ${questions.toString()}");
  }
  return questions;
}
