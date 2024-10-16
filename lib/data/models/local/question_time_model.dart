import 'package:xpuzzle/domain/entities/time.dart';

class QuestionTimeModel extends QuestionTime {
  QuestionTimeModel(
      {required super.id,
      required super.minutes,
      required super.seconds,
      required super.isPPAndPS,
      required super.isPPAndNS,
      required super.isNPAndNS,
      required super.isNPAndPS});

  QuestionTimeModel.copy(QuestionTime questionTime)
      : this(
          id: questionTime.id,
          minutes: questionTime.minutes,
          seconds: questionTime.seconds,
          isPPAndNS: questionTime.isPPAndNS,
          isPPAndPS: questionTime.isPPAndPS,
          isNPAndPS: questionTime.isNPAndPS,
          isNPAndNS: questionTime.isNPAndNS,
        );

  static QuestionTimeModel fromJson(Map<String, dynamic> json) {
    return QuestionTimeModel(
      id: json['id'],
      minutes: json['minutes'],
      seconds: json['seconds'],
      isPPAndPS: json['is_pp_and_ps'] == 0 ? false : true,
      isPPAndNS: json['is_pp_and_ns'] == 0 ? false : true,
      isNPAndNS: json['is_np_and_ns'] == 0 ? false : true,
      isNPAndPS: json['is_np_and_ps'] == 0 ? false : true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'minutes': minutes,
      'seconds': seconds,
      'is_pp_and_ps': isPPAndPS ? 1 : 0,
      'is_pp_and_ns': isPPAndNS ? 1 : 0,
      'is_np_and_ns': isNPAndNS ? 1 : 0,
      'is_np_and_ps': isNPAndPS ? 1 : 0,
    };
  }
}
