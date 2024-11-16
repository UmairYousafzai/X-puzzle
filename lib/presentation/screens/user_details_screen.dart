import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/presentation/widgets/custom_textfield_widget.dart';
import 'package:xpuzzle/presentation/widgets/text_widget.dart';
import 'package:xpuzzle/utils/constants.dart';
import '../providers/signupProvider.dart';
import '../widgets/background_image_container.dart';
import '../widgets/buttons/buttons.dart';

class UserDetailsScreen extends ConsumerWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpState = ref.watch(signUpProvider);
    final signUpNotifier = ref.read(signUpProvider.notifier);

    void handleButtonClick() {
      if (signUpState.firstName.isNotEmpty &&
          signUpState.lastName.isNotEmpty &&
          signUpState.dob.isNotEmpty &&
          signUpState.email.isNotEmpty &&
          signUpState.firstNameError == null &&
          signUpState.lastNameError == null &&
          signUpState.dobError == null &&
          signUpState.emailError == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All fields are valid.'))
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter valid Inputs')),
        );
      }
    }

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: BackgroundImageContainer(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/logos/X-Puzzles-logo.png',
                ),
                const Gap(18),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF1E2D7C),
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                      children: const [
                        TextSpan(text: "Sign up to\n"),
                        TextSpan(text: "unlock the world of X Puzzle"),
                      ],
                    ),
                  ),
                ),
                Gap(context.screenHeight * 0.035),

                const TextWidget(
                  text: 'First Name',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                Gap(context.screenHeight * 0.01),
                CustomTextField(
                  hintText: 'Enter your First name',
                  errorText: signUpState.firstNameError,
                  onChanged: (value) {
                    signUpNotifier.updateFirstName(value);
                  },
                ),
                Gap(context.screenHeight * 0.01),

                const TextWidget(
                  text: 'Last Name',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                Gap(context.screenHeight * 0.01),
                CustomTextField(
                  hintText: 'Enter your Last name',
                  errorText: signUpState.lastNameError,
                  onChanged: (value) {
                    signUpNotifier.updateLastName(value);
                  },
                ),
                Gap(context.screenHeight * 0.01),

                const TextWidget(
                  text: 'DOB',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                Gap(context.screenHeight * 0.01),
                CustomTextField(
                  hintText: 'Enter your DOB',
                  showIconButton: true,
                  errorText: signUpState.dobError,
                  onChanged: (value) {
                    signUpNotifier.updateDOB(value);
                  },
                ),
                Gap(context.screenHeight * 0.01),

                // Email Field
                const TextWidget(
                  text: 'Email',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                Gap(context.screenHeight * 0.01),
                CustomTextField(
                  hintText: 'Enter your email (optional)',
                  errorText: signUpState.emailError,
                  onChanged: (value) {
                    signUpNotifier.updateEmail(value);
                  },
                ),
                Gap(context.screenHeight * 0.04),

                primaryButton(
                  handleButtonClick,
                  'Continue',
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
