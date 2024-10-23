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
  Set<String> uniquePair = {};
  Random random = Random();

  while (questions.length < numberOfQuestion) {
    int left = 0;
    int right = 0;
    if (isPPAndPS) {
      left = random.nextInt(20) + 1;
      right = random.nextInt(20) + 1;
    } else if (isPPAndNS) {
      left = -(random.nextInt(20) + 1);
      right = -random.nextInt(20) + 1;
    } else if (isNPAndPS) {
      left = random.nextInt(19) + 2;
      right = -(random.nextInt(left - 1) + 1);
    } else if (isNPAndNS) {
      left = random.nextInt(10) + 1;
      right = -(random.nextInt(10) + left + 1);
    }

    String pair = '$left,$right';

    if(!uniquePair.contains(pair)){

      uniquePair.add(pair);
      final sum = left + right;
      final product = left * right;
      var question = Question(
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
      );

        questions.add(question);
    }
    }



  if (kDebugMode) {
    print("generated question values==============> ${questions.toString()}");
  }
  return questions;
}
