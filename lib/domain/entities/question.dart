class Question {
  Question({
    required this.id,
    required  this.numOne,
    required this.numTwo,
    required this.inputNumOne,
    required this.inputNumTwo,
    required this.topNum,
    required this.bottomNum,
    required this.isComplete,
    required this.isCorrect,
    required this.isPPAndPS,
    required this.isPPAndNS,
    required this.isNPAndNS,
    required this.isNPAndPS,
  });

  int? id;
  String numOne;
  String numTwo;
  String inputNumOne;
  String inputNumTwo;
  String topNum;
  String bottomNum;

  bool isComplete;
  bool isCorrect;
  bool isPPAndPS;
  bool isPPAndNS;
  bool isNPAndNS;
  bool isNPAndPS;
}
