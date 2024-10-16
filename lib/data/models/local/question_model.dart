import 'package:xpuzzle/domain/entities/question.dart';

class QuestionModel extends Question {
  QuestionModel(
      {required super.id,
      required super.numOne,
      required super.numTwo,
      required super.topNum,
      required super.bottomNum,
      required super.isComplete,
      required super.isCorrect,
      required super.isPPAndPS,
      required super.isPPAndNS,
      required super.isNPAndNS,
      required super.isNPAndPS});

  QuestionModel.copy(Question question)
      : this(
          id: question.id,
          numOne: question.numOne,
          numTwo: question.numTwo,
          topNum: question.topNum,
          bottomNum: question.bottomNum,
          isComplete: question.isComplete,
          isCorrect: question.isCorrect,
          isPPAndNS: question.isPPAndNS,
          isPPAndPS: question.isPPAndPS,
          isNPAndPS: question.isNPAndPS,
          isNPAndNS: question.isNPAndNS,
        );

  static QuestionModel fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      numOne: json['num_one'],
      numTwo: json['num_two'],
      topNum: json['top_num'],
      bottomNum: json['bottom_num'],
      isComplete: json['is_complete'] == 0 ? false : true,
      isCorrect: json['is_correct'] == 0 ? false : true,
      isPPAndPS: json['is_pp_and_ps'] == 0 ? false : true,
      isPPAndNS: json['is_pp_and_ns'] == 0 ? false : true,
      isNPAndNS: json['is_np_and_ns'] == 0 ? false : true,
      isNPAndPS: json['is_np_and_ps'] == 0 ? false : true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'num_one': numOne,
      'num_two': numTwo,
      'top_num': topNum,
      'bottom_num': bottomNum,
      'is_complete': isComplete ? 1 : 0,
      'is_correct': isCorrect ? 1 : 0,
      'is_pp_and_ps': isPPAndPS ? 1 : 0,
      'is_pp_and_ns': isPPAndNS ? 1 : 0,
      'is_np_and_ns': isNPAndNS ? 1 : 0,
      'is_np_and_ps': isNPAndPS ? 1 : 0,
    };
  }
}
