import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xpuzzle/main.dart';
import 'package:xpuzzle/presentation/widgets/custom_number_input_formatter.dart';
import 'package:xpuzzle/utils/constants.dart';

import '../../theme/colors.dart';

Widget gameNumberTextField({
  required String value,
  required BuildContext context,
  required double fontSize,
  required Function(String) onChanged,
  required FocusNode focusNode,
  required bool hasError,
}) {
  return IntrinsicWidth(
    child: Container(
      width: 40.w,
      height: 40.h,
      // constraints: BoxConstraints(
      //   minWidth: context.screenWidth * 0.12,
      //   maxWidth: context.screenWidth * 0.18,
      //   minHeight: context.screenWidth * 0.12,
      //   maxHeight: context.screenWidth * 0.18,
      //
      // ),
      // height: context.screenHeight * 0.068,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: MColors().colorSecondaryBlueDark.withOpacity(0.3),
        border: Border.all(
          color: hasError ? Colors.red : const Color(0x800CD4F8),
          width: 1,
        ),
      ),
      child: TextField(
        enableInteractiveSelection: false,
        cursorColor: MColors().colorSecondaryBlueDark,
        focusNode: focusNode,
        inputFormatters: [
          // FilteringTextInputFormatter.
          CustomNumberInputFormatter(),
          LengthLimitingTextInputFormatter(5),
        ],
        keyboardType: const TextInputType.numberWithOptions(signed: true,decimal: true),
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
        decoration:  InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
        ),
        onChanged: onChanged,
      ),
    ),
  );
}
