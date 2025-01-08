import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:xpuzzle/domain/entities/user.dart';
import 'package:xpuzzle/presentation/screens/subscription_screen.dart';
import 'package:xpuzzle/presentation/theme/colors.dart';
import 'package:xpuzzle/presentation/widgets/custom_textfield_widget.dart';
import 'package:xpuzzle/presentation/widgets/text_widget.dart';
import 'package:xpuzzle/utils/constants.dart';
import 'package:xpuzzle/utils/navigation/navigate.dart';

import '../../providers/shared_pref_provider.dart';
import '../../providers/signupProvider.dart';
import '../../widgets/background_image_container.dart';
import '../../widgets/buttons/buttons.dart';
import '../home_screen/home_screen.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() {
    return _SignupScreen();
  }
}

class _SignupScreen extends ConsumerState<SignupScreen> {
  late TextEditingController dobController;
  final firstNameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    dobController = TextEditingController(text: ref.read(signUpProvider).dob);
  }

//Function  for the field validation and saving user data
  void handleButtonClick() async {
    var sharedPreferencesHelper = ref.read(sharedPreferencesProvider).value!;
    var signUpState = ref.watch(signUpProvider);
    var signUpNotifier = ref.read(signUpProvider.notifier);

    signUpNotifier.updateFirstName(signUpState.firstName);
    signUpNotifier.updateLastName(signUpState.lastName);
    //signUpNotifier.updateDOB(signUpState.dob);
    signUpNotifier.updateEmail(signUpState.email);

    String firstNameError = signUpState.firstNameError ?? "";
    String lastNameError = signUpState.lastNameError ?? "";
    //String dobError = signUpState.dobError ?? "";
    String emailError = signUpState.emailError ?? "";

    if (signUpState.firstName.isNotEmpty &&
        signUpState.lastName.isNotEmpty &&
        // signUpState.dob.isNotEmpty &&
        firstNameError.isEmpty &&
        lastNameError.isEmpty &&
        // dobError.isEmpty &&
        emailError.isEmpty) {
      User user = User(
        firstName: signUpState.firstName,
        lastName: signUpState.lastName,
        dob: signUpState.dob,
        email: signUpState.email,
      );

      await sharedPreferencesHelper.saveUser(user).then((value) async {
        // Retrieve the subscription status
        bool? isSubscribed = sharedPreferencesHelper.getBool("isSubscription");

        // Navigate based on the subscription status
        if (isSubscribed == true) {
          navigatePushReplacement(
              context, const HomeScreen()); // Navigate to HomeScreen
        } else {
          navigatePushReplacement(context,
              const SubscriptionScreen()); // Navigate to SubscriptionScreen
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid inputs')),
      );
    }
  }

  void openDatePicker(TextEditingController dobController) async {
    var signUpNotifier = ref.read(signUpProvider.notifier);
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
                primary: MColors().colorSecondaryBlueDark // Selected date color
                ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    MColors().colorSecondaryBlueDark, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd')
          .format(pickedDate); // Format date as YYYY-MM-DD
      signUpNotifier.updateDOB(formattedDate);
      dobController.text = formattedDate; // Update the TextField value
    }
  }

  @override
  Widget build(BuildContext context) {
    final signUpState = ref.watch(signUpProvider);
    final signUpNotifier = ref.read(signUpProvider.notifier);

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
                        TextSpan(text: "Sign up to\n"),
                        TextSpan(text: "unlock the world of X Puzzler"),
                      ],
                    ),
                  ),
                ),
                Gap(context.screenHeight * 0.035),
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: TextWidget(
                    text: 'First Name',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(context.screenHeight * 0.01),
                CustomTextField(
                  hintText: 'Enter your First name',
                  errorText: signUpState.firstNameError ?? "",
                  focusNode: firstNameFocusNode,
                  onChanged: (value) => signUpNotifier.updateFirstName(value),
                ),
                Gap(context.screenHeight * 0.01),
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: TextWidget(
                    text: 'Last Name',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(context.screenHeight * 0.01),
                CustomTextField(
                  hintText: 'Enter your Last name',
                  errorText: signUpState.lastNameError ?? "",
                  focusNode: lastNameFocusNode,
                  onChanged: (value) => signUpNotifier.updateLastName(value),
                ),
                Gap(context.screenHeight * 0.01),
                // const Padding(
                //   padding: EdgeInsets.only(left: 12),
                //   child: TextWidget(
                //     text: 'DOB',
                //     fontSize: 14,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                // Gap(context.screenHeight * 0.01),
                // CustomTextField(
                //   hintText: 'Enter your DOB',
                //   showIconButton: true,
                //   errorText: signUpState.dobError ?? "",
                //   onChanged: (value) => signUpNotifier.updateDOB(value),
                //   onTap: () {
                //     openDatePicker(dobController);
                //   },
                //   onIconPressed: () {
                //     openDatePicker(dobController);
                //   },
                //   controller: dobController,
                //   disableField: true,
                // ),
                Gap(context.screenHeight * 0.01),
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
                  hintText: 'Enter your email (optional)',
                  errorText: signUpState.emailError ?? "",
                  focusNode: emailFocusNode,
                  onChanged: (value) => signUpNotifier.updateEmail(value),
                ),
                Gap(context.screenHeight * 0.04),
                primaryButton(
                  handleButtonClick,
                  'Continue',
                  Colors.black,
                  context,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
