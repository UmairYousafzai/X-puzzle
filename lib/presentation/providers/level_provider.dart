import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xpuzzle/presentation/providers/shared_pref_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Change from StateNotifier to AsyncNotifier to handle async initialization
class LevelProviderNotifier extends AsyncNotifier<String?> {
  @override
  Future<String?> build() async {
    final sharedPreferencesHelper = ref.watch(sharedPreferencesProvider).value;
    return sharedPreferencesHelper?.getLevel() ; // Default to "Level 1" if null
  }

  void updateLevel(String level) {
    state = AsyncValue.data(level); // Update the state
    final sharedPreferencesHelper = ref.read(sharedPreferencesProvider).value;
    sharedPreferencesHelper?.saveString("level", level); // Save to SharedPreferences
  }
}

final levelProvider = AsyncNotifierProvider<LevelProviderNotifier, String?>(
      () => LevelProviderNotifier(),
);


final levelListProvider = Provider<List<String>>((ref) {
  return [
    'Select Level',
    'Level 1',
    'Level 2',
    'Level 3',
    'Level 4',
  ];
});
