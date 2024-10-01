import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xpuzzle/utils/constants.dart';
import '../../../theme/colors.dart';

Widget gameNumberTextField({
  required String value,
  required BuildContext context,
  required double fontSize,
  required Function(String) onChanged,
  required FocusNode focusNode,
}) {
  return IntrinsicWidth(
    child: Container(
      constraints: BoxConstraints(
        minWidth: context.screenWidth * 0.12,
        maxWidth: context.screenWidth * 0.18,
      ),
      height: context.screenHeight * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: MColors().colorSecondaryBlueDark.withOpacity(0.3),
        border: Border.all(
          color: const Color(0x800CD4F8),
          width: 1,
        ),
      ),
      child: TextField(
    //     onTapOutside: (event) {
    // FocusManager.instance.primaryFocus?.unfocus();
    // },
        enableInteractiveSelection: false,
        cursorColor: MColors().colorSecondaryBlueDark,

        focusNode: focusNode,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(4),
        ],
        keyboardType: TextInputType.number,
        controller: TextEditingController.fromValue(
          TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(offset: value.length),
          ),
        ),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          color: MColors().colorSecondaryBlueDark,
          fontSize: fontSize,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
        ),
        onChanged: onChanged,
      ),
    ),
  );
}