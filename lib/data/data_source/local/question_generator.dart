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
      left = random.nextInt(8) + 1;
      right = random.nextInt(7) + 1;
    } else if (isPPAndNS) {
      right = random.nextInt(7) + 2;
      left = -(random.nextInt(right - 1) + 1);
      right *= -1;
    } else if (isNPAndPS) {
      left = random.nextInt(7) + 2;
      right = -(random.nextInt(left - 1) + 1);
    } else if (isNPAndNS) {
      left = random.nextInt(5) + 2;
      right = -(random.nextInt(left) + left + 1);
    }

    List<int> pairList = [left, right]..sort();
    String pair = '${pairList[0]},${pairList[1]}';

    if (!uniquePair.contains(pair) && (left.abs()) != right.abs()) {
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

List<Question> generatePPAndPS() {
  var random = Random();
  Set<int> usedRoots = {};
  List<Question> questions = [];

  while (questions.length < 10) {
    int c = random.nextInt(9) + 2; // Random c between 1 and 81

    int b = random.nextInt(c-1) + 1; // Random b between 1 and 81
    int discriminant = b * b - 4 * c;
    print('b: ${b} and C: ${c}');

    if (discriminant < 0 || (sqrt(discriminant) - sqrt(discriminant).toInt()).abs() > 0.0001) {
      continue; // Skip if discriminant is not a perfect square
    }

    // Solve the quadratic equation
    List<int>? roots = solveQuadratic(b, c);

    // Check if both roots are unique, positive, and integers
    if (roots != null &&
        roots[0] > 0 &&
        roots[1] > 0 &&
        roots[0] != roots[1] &&
        !usedRoots.contains(roots[0]) &&
        !usedRoots.contains(roots[1])) {
      // If valid, store the equation and roots
      String equation = 'x² + (${b})x + (${c}) = 0';

      var question = Question(
        id: null,
        numOne: roots[0].toString(),
        numTwo: roots[1].toString(),
        inputNumOne: "",
        inputNumTwo: "",
        topNum: c.toString(),
        bottomNum: b.toString(),
        isComplete: false,
        isCorrect: false,
        isPPAndPS: true,
        isPPAndNS: false,
        isNPAndPS: false,
        isNPAndNS: false,
      );

      questions.add(question);
      usedRoots.add(roots[0]);
      usedRoots.add(roots[1]);
    }
  }

  // Print the valid equations and roots
  for (var question in questions) {
    print('Equation: x² + (${question.bottomNum})x + (${question.topNum}) = 0');
    print('Roots: ${question.numOne} and ${question.numTwo}');
    print('');
  }

  return questions;
}

// Function to solve the quadratic equation and return roots if they are valid
List<int>? solveQuadratic(int b, int c) {
  // Calculate the discriminant
  double discriminant = (b * b - 4 * c).toDouble();

  if (discriminant < 0) {
    // No real roots
    return null;
  }

  // Calculate the roots using the quadratic formula
  double root1 = (-b + sqrt(discriminant)) / 2;
  double root2 = (-b - sqrt(discriminant)) / 2;
  print("rrots====>>> $root1  ,,, $root2");

  // Check if both roots are positive integers
  if (root1 > 0 && root2 > 0 && root1 == root1.toInt() && root2 == root2.toInt()) {
    return [root1.toInt(), root2.toInt()];
  }

  return null; // Return null if roots are not valid
}