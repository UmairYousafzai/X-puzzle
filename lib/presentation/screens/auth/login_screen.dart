import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/presentation/providers/loginProvider.dart';
import 'package:xpuzzle/presentation/widgets/custom_textfield_widget.dart';
import 'package:xpuzzle/presentation/widgets/text_widget.dart';
import 'package:xpuzzle/utils/constants.dart';

import '../../providers/shared_pref_provider.dart';
import '../../providers/signupProvider.dart';
import '../../widgets/background_image_container.dart';
import '../../widgets/buttons/buttons.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends ConsumerState<LoginScreen> {
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

//Function  for the field validation and saving user data
  void handleButtonClick() async {
    var sharedPreferencesHelper = ref.read(sharedPreferencesProvider).value!;
    var loginState = ref.watch(loginProvider);
    var signUpNotifier = ref.read(signUpProvider.notifier);
    signUpNotifier.updateEmail(loginState.email);
    String emailError = loginState.emailError ?? "";
    String passwordError = loginState.passwordError ?? "";
    if (loginState.email.isNotEmpty &&
        emailError.isEmpty &&
        loginState.password.isNotEmpty &&
        passwordError.isEmpty) {
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid inputs')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: BackgroundImageContainer(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/app_name.png')),
                const Gap(15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: const TextSpan(
                      style: TextStyle(
                        fontFamily: 'BalooDa2',
                        color: Color(0xFF1E2D7C),
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                      children: [
                        TextSpan(text: "Login to\n"),
                        TextSpan(text: "unlock the world of X Puzzler"),
                      ],
                    ),
                  ),
                ),
                Gap(context.screenHeight * 0.035),
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: TextWidget(
                    text: 'Email',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(context.screenHeight * 0.01),
                CustomTextField(
                  hintText: 'Enter your email ',
                  errorText: loginState.emailError ?? "",
                  focusNode: emailFocusNode,
                  onChanged: (value) => loginNotifier.updateEmail(value),
                ),
                Gap(context.screenHeight * 0.02),
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: TextWidget(
                    text: 'Password',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(context.screenHeight * 0.01),
                CustomTextField(
                  hintText: 'Enter your password',
                  errorText: loginState.passwordError ?? "",
                  focusNode: passwordFocusNode,
                  onChanged: (value) => loginNotifier.updatePassword(value),
                ),
                Gap(context.screenHeight * 0.04),
                primaryButton(
                  handleButtonClick,
                  'Login',
                  Colors.black,
                  context,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
