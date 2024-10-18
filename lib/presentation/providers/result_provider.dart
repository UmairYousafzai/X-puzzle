import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xpuzzle/presentation/providers/shared_pref_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultNotifier extends StateNotifier<Map<String, dynamic>> {
  ResultNotifier()
      : super({
          "isPPAndPS": false,
          "isPPAndNS": false,
          "isNPAndPS": false,
          "isNPAndNS": false,
          "is_loading": false
        });

  void setQuestionType(
      {bool isPPAndPS = false,
      bool isPPAndNS = false,
      bool isNPAndPS = false,
      bool isNPAndNS = false}) {
    state = {
      ...state,
      "isPPAndPS": isPPAndPS,
      "isPPAndNS": isPPAndNS,
      "isNPAndPS": isNPAndPS,
      "isNPAndNS": isNPAndNS,
    };
  }

  void setLoading(bool isLoading) {
    state = {...state, "is_loading": isLoading};
  }
}

final resultProvider =
    StateNotifierProvider<ResultNotifier, Map<String, dynamic>>(
  (ref) => ResultNotifier(),
);
