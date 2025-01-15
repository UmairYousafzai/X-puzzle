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
                : isSubscribed
                    ? const HomeScreen()
                    : const SubscriptionScreen(),
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

  Widget gridItemDesign(Question question) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 15.h),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 2,
              // offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SvgPicture.asset(
                    "assets/images/svgs/cross_sign.svg",
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("x",
                                  style: TextStyle(
                                      color: MColors().colorSecondaryOrangeDark,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                question.topNum,
                                style: TextStyle(
                                    fontFamily: 'BalooDa2',
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: Container(
                              width: 10,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 3.0, top: 3, right: 3, bottom: 3),
                                child: Text(
                                  question.inputNumOne,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'BalooDa2',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  // Add ellipsis for long text
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Flexible(
                            child: Container(
                              width: 10,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 3.0, top: 3, right: 3, bottom: 3),
                                child: Text(
                                  question.inputNumTwo,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'BalooDa2',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            question.bottomNum,
                            style: TextStyle(
                                fontFamily: 'BalooDa2',
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Text("+",
                style: TextStyle(
                    color: MColors().colorSecondaryOrangeDark,
                    fontFamily: 'BalooDa2',
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
