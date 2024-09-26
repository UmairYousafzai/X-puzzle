import 'package:flutter_riverpod/flutter_riverpod.dart';

final levelProvider = StateProvider<String?>((ref) { //StateProvider for managing state
  return null;
});


final levelListProvider = Provider<List<String>>((ref) { // Provider is for immutable data
  return [
    'Level 1',
    'Level 2',
    'Level 3',
    'Level 4',
    'Level 5',
  ];
});
