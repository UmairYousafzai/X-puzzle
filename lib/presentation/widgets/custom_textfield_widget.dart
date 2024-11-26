import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? errorText;
  final Function(String) onChanged;
  final bool showIconButton;
  final VoidCallback? onIconPressed;
  final TextEditingController? controller;
  final bool? disableField;
  final FocusNode? focusNode; // Unique FocusNode for each field

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.errorText,
    this.showIconButton = false,
    this.onIconPressed,
    this.controller,
    this.disableField,
    this.focusNode, // Accepting FocusNode as a parameter
  });

  @override
  Widget build(BuildContext context) {
    final node =
        focusNode ?? FocusNode(); // Use provided FocusNode or create one

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
                child: GestureDetector(
                  onTap: () {
                    if (disableField != true) {
                      node.requestFocus();
                    }
                  },
                  child: TextField(
                    controller: controller,
                    onChanged: onChanged,
                    keyboardType: TextInputType.text,
                    focusNode: node, // Assigning the unique FocusNode
                    enabled: disableField != true,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black, // Set the text color to black
                    ),
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
              ),
              if (showIconButton)
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/svg/calendar_icon.svg',
                    height: 20,
                    width: 20,
                  ),
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
