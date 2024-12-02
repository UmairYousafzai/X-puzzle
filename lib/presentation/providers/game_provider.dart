import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xpuzzle/domain/entities/time.dart';
import 'package:xpuzzle/domain/use_cases/store_time.dart';
import 'package:xpuzzle/presentation/providers/time/time_use_case_provider.dart';
import '../../domain/entities/question.dart';

class GameState {
  final String firstNumber;
  final String secondNumber;
  String selectedNumber;
  final int timerSeconds;
  final int minutes;
  final int seconds;
  final int? timeID;
  final int questionIndex;
  final int questionProgress;
  bool isTimerRunning;
  bool isTimerFinished;
  bool hasErrorOnTextFieldOne;
  bool hasErrorOnTextFieldTwo;
  FocusNode firstNumberFocus;
  FocusNode secondNumberFocus;
  Question? question;

  GameState({
    this.firstNumber = '',
    this.secondNumber = '',
    this.selectedNumber = '',
    this.timerSeconds = 0,
    this.minutes = 5,
    this.seconds = 0,
    this.timeID,
    this.questionIndex = 0,
    this.questionProgress = 0,
    this.isTimerRunning = false,
    this.isTimerFinished = false,
    this.hasErrorOnTextFieldOne = false,
    this.hasErrorOnTextFieldTwo = false,
    required this.firstNumberFocus,
    required this.secondNumberFocus,
    this.question,
  });

  GameState copyWith({
    String? firstNumber,
    String? secondNumber,
    String? selectedNumber,
    int? timerSeconds,
    int? minutes,
    int? seconds,
    int? timeID,
    int? questionIndex,
    int? questionProgress,
    bool? isTimerRunning,
    bool? isTimerFinished,
    bool? hasErrorOnTextFieldOne,
    bool? hasErrorOnTextFieldTwo,
    FocusNode? firstNumberFocus,
    FocusNode? secondNumberFocus,
    Question? question,
  }) {
    return GameState(
      firstNumber: firstNumber ?? this.firstNumber,
      secondNumber: secondNumber ?? this.secondNumber,
      selectedNumber: selectedNumber ?? this.selectedNumber,
      timerSeconds: timerSeconds ?? this.timerSeconds,
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
      timeID: timeID ?? this.timeID,
      questionIndex: questionIndex ?? this.questionIndex,
      questionProgress: questionProgress ?? this.questionProgress,
      isTimerRunning: isTimerRunning ?? this.isTimerRunning,
      isTimerFinished: isTimerFinished ?? this.isTimerFinished,
      hasErrorOnTextFieldOne:
          hasErrorOnTextFieldOne ?? this.hasErrorOnTextFieldOne,
      hasErrorOnTextFieldTwo:
          hasErrorOnTextFieldTwo ?? this.hasErrorOnTextFieldTwo,
      firstNumberFocus: firstNumberFocus ?? this.firstNumberFocus,
      secondNumberFocus: secondNumberFocus ?? this.secondNumberFocus,
      question: question ?? this.question,
    );
  }

  String getLevel() {
    if (question?.isPPAndPS ?? false) {
      return "Level 1";
    } else if (question?.isPPAndNS ?? false) {
      return "Level 2";
    } else if (question?.isNPAndPS ?? false) {
      return "Level 3";
    } else {
      return "Level 4";
    }
  }
}

class GameNotifier extends StateNotifier<GameState> {
  Timer? _timer;
  final StoreTime storeTime;

  GameNotifier(this.storeTime)
      : super(GameState(
          firstNumberFocus: FocusNode(),
          secondNumberFocus: FocusNode(),
        ));

  void updateFirstNumber(String value) {
    state = state.copyWith(firstNumber: value);
  }

  void updateSecondNumber(String value) {
    state = state.copyWith(secondNumber: value);
  }

  void updateSelectedNumber(String value) {
    state = state.copyWith(selectedNumber: value);
  }

  void updateQuestionIndex(int index) {
    state = state.copyWith(questionIndex: index);
  }

  void updateQuestion(Question question) {
    state = state.copyWith(question: question, firstNumber: "", secondNumber: "");
    // state = state.copyWith(question: question);
  }

  void updateTimer(int seconds) {
    state = state.copyWith(timerSeconds: seconds);
  }

  void updateQuestionProgress() {
    var progress = state.questionProgress;
    progress++;
    state = state.copyWith(questionProgress: progress);
  }

  void setQuestionProgress(int value) {
    var progress = value;
    state = state.copyWith(questionProgress: progress);
  }

  void setTime(int minutes, int seconds, int? timeID) {
    state = state.copyWith(minutes: minutes, seconds: seconds, timeID: timeID);
  }

  void setErrorOnInputOne(bool error) {
    state = state.copyWith(hasErrorOnTextFieldOne: error);
  }

  void setErrorOnInputTwo(bool error) {
    state = state.copyWith(hasErrorOnTextFieldTwo: error);
  }

  void playTimer() {
    if (state.isTimerRunning) return;
    state = state.copyWith(isTimerRunning: true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.minutes > 0 || state.seconds > 0) {
        _tick(); // Update the timer every second
      } else {
        timer.cancel();
        state = state.copyWith(isTimerRunning: false, isTimerFinished: true);
      }
    });
  }

  void _tick() {
    int newSeconds = state.seconds - 1;
    int newMinutes = state.minutes;

    if (newSeconds < 0) {
      newMinutes -= 1;
      newSeconds = 59;
    }

    if (newMinutes < 0) {
      newMinutes = 0;
      newSeconds = 0;
      _timer?.cancel();
    }
    state = state.copyWith(minutes: newMinutes, seconds: newSeconds);
    updateTimeInDB();
  }

  void pauseTimer() {
    _timer?.cancel();
    state = state.copyWith(isTimerRunning: false);
  }

  void resetTimer() {
    _timer?.cancel();
    state = GameState(
      firstNumber: '',
      secondNumber: '',
      selectedNumber: '',
      timerSeconds: 0,
      minutes: 5,
      seconds: 0,
      questionIndex: 0,
      isTimerRunning: false,
      firstNumberFocus: FocusNode(),
      // Create new instances
      secondNumberFocus: FocusNode(),
      question: null, // Reset or set the desired initial question
    );
  }

  void resetGame() {
    _timer?.cancel();
    state = GameState(
        firstNumberFocus: FocusNode(), secondNumberFocus: FocusNode());
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cleanup the timer
    super.dispose();
  }

  void updateTimeInDB() async {
    var id = await storeTime.execute(QuestionTime(
        id: state.timeID,
        minutes: state.minutes,
        seconds: state.seconds,
        isPPAndPS: state.question?.isPPAndPS ?? false,
        isPPAndNS: state.question?.isPPAndNS ?? false,
        isNPAndNS: state.question?.isNPAndNS ?? false,
        isNPAndPS: state.question?.isNPAndPS ?? false));
    state = state.copyWith(timeID: id);
  }
}

final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  return GameNotifier(ref.read(storeTimeUseCaseProvider));
});
