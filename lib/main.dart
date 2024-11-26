import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xpuzzle/presentation/providers/shared_pref_provider.dart';
import 'package:xpuzzle/presentation/screens/select_level_screen.dart';
import 'package:xpuzzle/presentation/screens/user_details_screen.dart';
import 'package:xpuzzle/presentation/theme/app_theme.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
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

    return ScreenUtilInit(
      designSize: const Size(378.39, 787.41),
      minTextAdapt: true,
      builder: (context, child) => sharedPreferencesHelper.when(
        data: (helper) {
          final user = helper.getUser();
          if (kDebugMode) {
            print("heigth  size: ${MediaQuery.of(context).size.height}");
            print("width  size: ${MediaQuery.of(context).size.width}");
          }
          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ));
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'X Puzzle',
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
                ? const UserDetailsScreen()
                : const SelectLevelScreen(),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Text('Error: $err'),
      ),
    );
  }
}
