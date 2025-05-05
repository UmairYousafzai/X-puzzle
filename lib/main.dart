import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xpuzzle/presentation/providers/shared_pref_provider.dart';
import 'package:xpuzzle/presentation/screens/auth/login_screen.dart';
import 'package:xpuzzle/presentation/screens/home_screen/home_screen.dart';
import 'package:xpuzzle/presentation/screens/subscription_screen.dart';
import 'package:xpuzzle/presentation/theme/app_theme.dart';
import 'package:xpuzzle/presentation/theme/colors.dart';
import 'package:xpuzzle/utils/constants.dart';
import 'domain/entities/question.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const ProviderScope(child: MyApp()));
  FlutterNativeSplash.remove();
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharedPreferencesHelper = ref.watch(sharedPreferencesProvider);

    // var questions = generatePositiveMultipleAndPositiveInteger();
    return ScreenUtilInit(
      designSize: const Size(378.39, 787.41),
      minTextAdapt: true,
      builder: (context, child) => sharedPreferencesHelper.when(
        data: (helper) {
          final user = helper.getUser();
          final isSubscribed = helper.getBool("isSubscription") ?? false;

          if (kDebugMode) {
            print("heigth  size: ${MediaQuery.of(context).size.height}");
            print("width  size: ${MediaQuery.of(context).size.width}");
          }
          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ));
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'X Puzzler',
            theme: theme,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.noScaling,
                ),
                child: child!,
              );
            },
            home: user == null
                ? const LoginScreen()
                :  const HomeScreen()
                    // : const SubscriptionScreen(),
          );
        },
        loading: () => Container(
            width: context.screenWidth,
            height: context.screenHeight,
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator())),
        error: (err, stack) => Text('Error: $err'),
      ),
    );
  }

}
