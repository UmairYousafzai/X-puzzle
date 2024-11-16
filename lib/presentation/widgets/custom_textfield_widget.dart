import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? errorText; // Error text to display under the TextField
  final Function(String) onChanged; // onChanged callback for validation
  final bool showIconButton; // To show the calendar icon button

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.onChanged, // Required onChanged parameter
    this.errorText,
    this.showIconButton = false, // Default value set to false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBF3), // Background color #FFFBF3
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: onChanged,
                  keyboardType: TextInputType.text, // Default keyboard
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 20),
                    hintText: hintText,
                    hintStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (showIconButton) // Show the IconButton if true
                IconButton(
                  icon: const Icon(
                    Icons.calendar_month, // Permanent calendar icon
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    // Define your action when the calendar icon is pressed
                  },
                ),
            ],
          ),
        ),
        if (errorText != null) // Show error message if validation fails
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
