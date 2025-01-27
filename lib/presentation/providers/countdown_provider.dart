import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountdownNotifier extends StateNotifier<int> {
  Timer? _timer;

  CountdownNotifier() : super(60);

  void startCountdown() {
    state = 60; // Immediately update state to 60
    _timer?.cancel();

    // Create new timer
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      // Use setState to ensure UI updates
      state = state - 1;

      if (state <= 0) {
        _timer?.cancel();
        state = 0; // Ensure we don't go below 0
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final countdownProvider = StateNotifierProvider<CountdownNotifier, int>((ref) {
  return CountdownNotifier();
});