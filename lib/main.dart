import 'dart:async';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gaushala/router.locator.dart';
import 'package:gaushala/router.router.dart';
import 'package:stacked_services/stacked_services.dart';

import 'screens/splash_screen/splash_screen.dart';
import 'themes/color_schemes.g.dart';
import 'themes/custom_color.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightScheme;
        ColorScheme darkScheme;

        // Default to orange if dynamic colors are not available
        if (lightDynamic != null && darkDynamic != null) {
          lightScheme = lightDynamic.harmonized();
          darkScheme = darkDynamic.harmonized();
        } else {
          lightScheme = lightColorScheme.copyWith(primary: Colors.yellow);
          darkScheme = darkColorScheme.copyWith(primary: Colors.yellow);
        }

        // Override specific colors to ensure orange is used
        lightScheme = lightScheme.copyWith(
          primary: Colors.yellow,
          onPrimary: Colors.white, // Ensure contrast for text/icons on primary
        );

        darkScheme = darkScheme.copyWith(
          primary: Colors.yellow,
          onPrimary: Colors.white, // Ensure contrast for text/icons on primary
        );

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: StackedService.navigatorKey,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'Poppins',
            colorScheme: lightScheme,
            iconTheme: const IconThemeData(color: Colors.black),
            textTheme: const TextTheme(
              displayLarge: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
              labelLarge: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: lightScheme.primary,
                foregroundColor: Colors.black,
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: lightScheme.primary,
              foregroundColor: Colors.black,
              iconTheme: const IconThemeData(color: Colors.black),
              titleTextStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            extensions: [lightCustomColors],
          ),

          themeMode: ThemeMode.light, // Set the default theme to light
          home: const SplashScreen(),
        );
      },
    );
  }
}
