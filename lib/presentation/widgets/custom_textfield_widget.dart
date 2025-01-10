import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String errorText;
  final Function(String) onChanged;
  final bool showIconButton;
  final VoidCallback? onIconPressed;
  final TextEditingController? controller;
  final bool? disableField;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final bool? obscureText; // Nullable property for initial obscure text state

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.errorText,
    this.showIconButton = false,
    this.onIconPressed,
    this.controller,
    this.disableField,
    this.focusNode,
    this.onTap,
    this.obscureText, // Nullable property for obscure text
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isObscured; // Internal state for toggling obscure text

  @override
  void initState() {
    super.initState();
    isObscured =
        widget.obscureText ?? false; // Initialize with provided value or false
  }

  void toggleObscureText() {
    setState(() {
      isObscured = !isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    final node = widget.focusNode ?? FocusNode();
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
                    if (widget.disableField != true) {
                      node.requestFocus();
                    }
                    if (widget.onTap != null) {
                      widget.onTap!();
                    }
                  },
                  child: TextField(
                    controller: widget.controller,
                    onChanged: widget.onChanged,
                    keyboardType: TextInputType.text,
                    focusNode: node,
                    onTap: widget.onTap,
                    enabled: widget.disableField != true,
                    obscureText: isObscured,
                    // Use the current obscure state
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black, // Set the text color to black
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                      hintText: widget.hintText,
                      hintStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      border: InputBorder.none,
                      suffixIcon: widget.obscureText != null
                          ? IconButton(
                              icon: Icon(
                                isObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed:
                                  toggleObscureText, // Toggle obscure text on tap
                            )
                          : null,
                    ),
                  ),
                ),
              ),
              if (widget.showIconButton)
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/svg/calendar_icon.svg',
                    height: 20,
                    width: 20,
                  ),
                  onPressed: widget.onIconPressed,
                ),
            ],
          ),
        ),
        if (widget.errorText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              widget.errorText,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
