import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameState {
  final String firstNumber;
  final String secondNumber;
  final int timerSeconds;
  final int minutes;
  final int seconds;
  bool isTimerRunning;

  GameState({
    this.firstNumber = '',
    this.secondNumber = '',
    this.timerSeconds = 0,
    this.minutes = 5,
    this.seconds = 0,
    this.isTimerRunning = false,
  });

  GameState copyWith({
    String? firstNumber,
    String? secondNumber,
    int? timerSeconds,
    int? minutes,
    int? seconds,
    bool? isTimerRunning,
  }) {
    return GameState(
      firstNumber: firstNumber ?? this.firstNumber,
      secondNumber: secondNumber ?? this.secondNumber,
      timerSeconds: timerSeconds ?? this.timerSeconds,
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
      isTimerRunning: isTimerRunning ?? this.isTimerRunning,
    );
  }
}

class GameNotifier extends StateNotifier<GameState> {
  Timer? _timer;

  GameNotifier() : super(GameState());

  void updateFirstNumber(String value) {
    state = state.copyWith(firstNumber: value);
  }

  void updateSecondNumber(String value) {
    state = state.copyWith(secondNumber: value);
  }

  void updateTimer(int seconds) {
    state = state.copyWith(timerSeconds: seconds);
  }

  // Play Timer (Starts the timer if not already running)
  void playTimer() {
    if (state.isTimerRunning) return; // Prevent multiple timers
    state = state.copyWith(isTimerRunning: true);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (state.minutes > 0 || state.seconds > 0) {
        _tick(); // Update the timer every second
      } else {
        timer.cancel();
        state = state.copyWith(isTimerRunning: false);
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
  }

  // Pause Timer
  void pauseTimer() {
    _timer?.cancel();
    state = state.copyWith(isTimerRunning: false);
  }

  // Reset Timer to 5 minutes
  void resetTimer() {
    _timer?.cancel();
    state = state.copyWith(minutes: 5, seconds: 0, isTimerRunning: false);
  }

  void resetGame() {
    state = GameState();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cleanup the timer
    super.dispose();
  }
}

final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  return GameNotifier();
});
