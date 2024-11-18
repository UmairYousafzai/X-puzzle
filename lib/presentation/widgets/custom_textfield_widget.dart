import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? errorText;
  final Function(String) onChanged;
  final bool showIconButton;
  final VoidCallback? onIconPressed;
  final TextEditingController? controller; // Added controller

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.errorText,
    this.showIconButton = false,
    this.onIconPressed,
    this.controller, // Accepting controller
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBF3),
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller, // Use the controller
                  onChanged: onChanged,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 20),
                    hintText: hintText,
                    hintStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (showIconButton)
                IconButton(
                  icon:  Image.asset('assets/icons/calendar_logo.png',height: 20,),
                  onPressed: onIconPressed,
                ),
            ],
          ),
        ),
        if (errorText != null)
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
