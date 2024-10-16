import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:xpuzzle/domain/entities/question.dart';

List<Question> generatePositiveMultipleAndPositiveInteger(
    {int numberOfQuestion = 0}) {
  List<Question> questions = [];
  for (int i = 0; i < numberOfQuestion; i++) {
    final left = Random().nextInt(20) + 1;
    final right = Random().nextInt(20) + 1;

    final sum = left + right;
    final product = left * right;

    questions.add(Question(
      id: null,
      numOne: left.toString(),
      numTwo: right.toString(),
      topNum: product.toString(),
      bottomNum: sum.toString(),
      isComplete: false,
      isCorrect: false,
      isPPAndNS: false,
      isPPAndPS: true,
      isNPAndPS: false,
      isNPAndNS: false,
    ));
  }
  if (kDebugMode) {
    print("generated question values==============> ${questions.toString()}");
  }
  return questions;
}
