import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xpuzzle/presentation/providers/shared_pref_provider.dart';

import '../../providers/level_provider.dart';

class DropdownFieldWidget extends ConsumerWidget {
  const DropdownFieldWidget({super.key, required this.onChanged});

  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the list of levels and the current selected level from the providers
    final levels = ref.watch(levelListProvider);
    final selectedValue = ref.watch(levelProvider);

    return DropdownButtonFormField<String>(
      value: selectedValue.when(data: (data) {
        onChanged(data);
        return data;
      }, error: (err, stack) {
        return "Level 1";
      }, loading: () {
        return "Level 1";
      }),
      onChanged: onChanged,
      items: levels.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      dropdownColor: const Color(0xFFFFFBF3),
      decoration: InputDecoration(
        fillColor: const Color(0xFFFFFBF3),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        labelText: 'Select Level',
        labelStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        suffixIcon:
            const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black),
      ),
      style: const TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
      isDense: true,
      icon: const SizedBox(),
    );
  }
}
