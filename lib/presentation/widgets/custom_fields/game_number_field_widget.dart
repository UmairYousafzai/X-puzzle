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

  var widgetBottomPadding= 0.0;
  if(context.screenHeight<smallDeviceThreshold){
    widgetBottomPadding= 10.r;
  }else if(context.screenHeight > 600 && context.screenHeight<800){
    widgetBottomPadding= 12.r;

  }else if(context.screenHeight >800){
    widgetBottomPadding= 10.r;

  }
  return IntrinsicWidth(
    child: Container(
      padding: EdgeInsets.only(bottom: widgetBottomPadding),
      width: 45.h,
      height: 45.h,
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
      child: Center(
        child: TextField(
          enableInteractiveSelection: false,
          cursorColor: MColors().colorSecondaryBlueDark,
          focusNode: focusNode,
          inputFormatters: [
            // FilteringTextInputFormatter.
            CustomNumberInputFormatter(),
            LengthLimitingTextInputFormatter(5),
          ],
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: true),
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: value,
              selection: TextSelection.collapsed(offset: value.length),
            ),
          ),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'BalooDa2',
            fontWeight: FontWeight.w700,
            color: MColors().colorSecondaryBlueDark,
                fontSize: fontSize.h,
              ),
          decoration: InputDecoration(
            border: InputBorder.none,
            // contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
          ),
          onChanged: onChanged,
        ),
      ),
    ),
  );
}
