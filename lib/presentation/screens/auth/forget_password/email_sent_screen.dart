import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xpuzzle/presentation/screens/auth/login_screen.dart';
import 'package:xpuzzle/presentation/widgets/background_image_container.dart';
import 'package:xpuzzle/presentation/widgets/svg_circular_container.dart';
import 'package:xpuzzle/utils/constants.dart';
import 'package:xpuzzle/utils/navigation/navigate.dart';
import '../../../providers/auth/loginProvider.dart';
import '../../../providers/countdown_provider.dart';
import '../../../theme/colors.dart';
import '../../../widgets/buttons/buttons.dart';

class EmailSentScreen extends ConsumerStatefulWidget {
  const EmailSentScreen({super.key});

  @override
  ConsumerState<EmailSentScreen> createState() => _EmailSentScreen();
}

class _EmailSentScreen extends ConsumerState<EmailSentScreen> {
  @override
  void initState() {
    super.initState();
    // Start countdown only once when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(countdownProvider.notifier).startCountdown();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginNotifier = ref.read(loginProvider.notifier);
    final countdown = ref.watch(countdownProvider);
    final countdownNotifier = ref.read(countdownProvider.notifier);

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: BackgroundImageContainer(
        showAppBar: true,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Email Sent',
                style: TextStyle(
                  fontFamily: 'BalooDa2',
                  color: Color(0xFF1E2D7C),
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 30.h),
              const SvgCircullarContainer(imagePath: "assets/icons/svg/sent_icon.svg"),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  emailSentLabel,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30.h),
              TextButton(
                onPressed: countdown == 0
                    ? () async {
                  await loginNotifier.resetPassword();
                  if (mounted) {
                    // Start new countdown and ensure state updates
                    ref.read(countdownProvider.notifier).startCountdown();
                  }
                }
                    : null,
                child: Text(
                  countdown == 0
                      ? "Resend Email"
                      : "Resend Email in $countdown sec",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: countdown == 0
                        ? MColors().brightOrange
                        : MColors().brightOrange.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    decorationColor: MColors().brightOrange,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              primaryButton(
                    () {
                  navigatePushAndRemoveUntil(context, const LoginScreen(), false);
                },
                'Done',
                Colors.black,
                context,
              )
            ],
          ),
        ),
      ),
    );
  }
}
