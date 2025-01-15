import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/presentation/screens/auth/signup_screen.dart';
import 'package:xpuzzle/presentation/theme/colors.dart';
import 'package:xpuzzle/presentation/widgets/custom_textfield_widget.dart';
import 'package:xpuzzle/presentation/widgets/text_widget.dart';
import 'package:xpuzzle/utils/constants.dart';
import 'package:xpuzzle/utils/helper_functions.dart';
import 'package:xpuzzle/utils/navigation/navigate.dart';

import '../../providers/auth/loginProvider.dart';
import '../../providers/firebase/firebase_usecase_provider.dart';
import '../../providers/shared_pref_provider.dart';
import '../../widgets/background_image_container.dart';
import '../../widgets/buttons/buttons.dart';
import '../home_screen/home_screen.dart';
import '../subscription_screen.dart';

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
    var loginNotifier = ref.read(loginProvider.notifier);
    final fetchUserUseCase = ref.read(fetchUserUseCaseProvider);

    // Validate input fields
    loginNotifier.updateEmail(loginState.email);
    loginNotifier.updatePassword(loginState.password);

    // Get the updated state after validation
    loginState = ref.watch(loginProvider);

    String emailError = loginState.emailError ?? "";
    String passwordError = loginState.passwordError ?? "";

    if (loginState.email.isNotEmpty &&
        emailError.isEmpty &&
        loginState.password.isNotEmpty &&
        passwordError.isEmpty) {
      try {
        await loginNotifier.login();
        loginState = ref.watch(loginProvider);

        // Show error message if login failed
        if (loginState.error!.isNotEmpty) {
          showSnackBar(loginState.error!, context);
          return; // Stop execution if there's an error
        }

        if (loginState.isSignedIn) {
          try {
            final user = await fetchUserUseCase.execute();
            await sharedPreferencesHelper.saveUser(user);
            bool? isSubscribed =
                sharedPreferencesHelper.getBool("isSubscription");

            if (isSubscribed == true) {
              navigatePushReplacement(context, const HomeScreen());
            } else {
              navigatePushReplacement(context, const SubscriptionScreen());
            }
          } catch (e) {
            showSnackBar(e.toString(), context);
          }
        }
      } catch (e) {
        showSnackBar(e.toString(), context);
      }
    } else {
      showSnackBar('Please enter valid inputs', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Stack(children: [
        BackgroundImageContainer(
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
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      fontFamily: 'BalooDa2',
                      color: Color(0xFF1E2D7C),
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                    ),
                  ),
                  Gap(context.screenHeight * 0.05),
                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: TextWidget(
                      text: 'Username/Email',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gap(context.screenHeight * 0.01),
                  CustomTextField(
                    hintText: 'Enter Username or Email ',
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
                    obscureText: true,
                  ),
                  Gap(context.screenHeight * 0.04),
                  primaryButton(
                    handleButtonClick,
                    'Login',
                    Colors.black,
                    context,
                  ),
                  Gap(context.screenHeight * 0.01),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        navigateToScreen(context, const SignupScreen());
                      },
                      child: const TextWidget(
                        text: "Don't have an account? SignUp",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
      ]),
    );
  }
}
