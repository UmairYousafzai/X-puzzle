import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/data_source/local/shared_preference_helper.dart';

final sharedPreferencesProvider =
    FutureProvider<SharedPreferencesHelper>((ref) async {
  return SharedPreferencesHelper(
    await SharedPreferences.getInstance(),
  );
});
