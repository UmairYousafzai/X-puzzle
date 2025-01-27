import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/presentation/screens/auth/forget_password/email_sent_screen.dart';
import 'package:xpuzzle/presentation/widgets/background_image_container.dart';
import 'package:xpuzzle/presentation/widgets/custom_textfield_widget.dart';
import 'package:xpuzzle/presentation/widgets/text_widget.dart';
import 'package:xpuzzle/utils/constants.dart';
import 'package:xpuzzle/utils/navigation/navigate.dart';
import '../../../../utils/helper_functions.dart';
import '../../../providers/auth/loginProvider.dart';
import '../../../theme/colors.dart';
import '../../../widgets/buttons/buttons.dart';
import '../../../widgets/svg_circular_container.dart';

class ForgetPasswordScreen extends ConsumerWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailFocusNode = FocusNode();
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);
    void handleButtonClick() {
      print("handle button is working-------------------------");
      var loginState = ref.watch(loginProvider);
      var loginNotifier = ref.read(loginProvider.notifier);
      loginNotifier.updateEmail(loginState.email);
      loginState = ref.watch(loginProvider);
      String emailError = loginState.emailError ?? "";
      if (loginState.email.isNotEmpty && emailError.isEmpty) {
        try {
          loginNotifier.resetPassword().then((val){
            navigateToScreen(context,  EmailSentScreen());
          });
        } catch (e) {
          showSnackBar(e.toString(), context);
        }
      }
      else{
        showSnackBar('Please enter valid email', context);
      }
    }


    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Stack(
        children: [
          BackgroundImageContainer(
            showAppBar: true,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Forgot Password',
                          style: TextStyle(
                            fontFamily: 'BalooDa2',
                            color: Color(0xFF1E2D7C),
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        const SvgCircullarContainer(
                          imagePath: "assets/icons/svg/lock_icon.svg",
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: const Text(
                            'Please Enter Your Email Address to Receive a Verification Code',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center, // Centers the text on each line
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: TextWidget(
                        text: 'Email Address',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gap(context.screenHeight * 0.01),
                    CustomTextField(
                      hintText: 'Enter Username or Email',
                      errorText: loginState.emailError??'',
                      focusNode: emailFocusNode,
                      onChanged: (value) => loginNotifier.updateEmail(value),
                    ),
                    Gap(context.screenHeight * 0.2),
                    primaryButton(
                      () {
                        handleButtonClick();
                      },
                      'Send',
                      Colors.black,
                      context,
                    )
                  ],
                ),
              ),
            ),
          ),
          if (loginState.isLoading)
            Container(
              color: Colors.white.withOpacity(0.5), // Semi-transparent overlay
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: MColors().colorSecondaryBlueDark,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
