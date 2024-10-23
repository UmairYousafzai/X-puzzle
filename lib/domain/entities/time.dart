class QuestionTime{

  QuestionTime({
    required this.id,
    required  this.minutes,
    required this.seconds,
    required this.isPPAndPS,
    required this.isPPAndNS,
    required this.isNPAndNS,
    required this.isNPAndPS,
  });
  int? id;
  int minutes;
  int seconds;
  bool isPPAndPS;
  bool isPPAndNS;
  bool isNPAndNS;
  bool isNPAndPS;}