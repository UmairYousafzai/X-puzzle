import 'package:flutter/services.dart';

class CustomNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Get the new input value
    final newText = newValue.text;

    // If the input is empty, return it as is (empty input allowed)
    if (newText.isEmpty) {
      return newValue;
    }

    // Check if the first character is a '+' or '-'
    final startsWithSign = newText.startsWith('+') || newText.startsWith('-');

    // Allow only digits after the first character (if there's a sign)
    final isValid = startsWithSign
        ? RegExp(r'^[-+]?[0-9]*$').hasMatch(newText)  // Only one sign allowed at the start
        : RegExp(r'^[0-9]*$').hasMatch(newText);     // No sign, only digits allowed

    // If valid, return the new value
    if (isValid) {
      return newValue;
    }

    // If not valid, return the old value (prevent the invalid input)
    return oldValue;
  }
}
