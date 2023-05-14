import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flarezchat/app/screens/intro/onBoardingScreens/utils/colors.dart';
import 'package:flarezchat/app/screens/intro/onBoardingScreens/view/onBoardingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/screens/intro/splash/SplashScreen.dart';
import 'app/screens/pages/HomeScreen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Get the SharedPreferences instance
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Check if the onboarding is complete
  bool onboardingComplete = prefs.getBool('onboarding_complete') ?? false;

  // Run the app
  runApp(MyApp(onboardingComplete: onboardingComplete));
}

class MyApp extends StatelessWidget {
  final bool onboardingComplete;

  const MyApp({Key? key, required this.onboardingComplete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flarezchat',
      theme: ThemeData(
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 25,
              color: MyColors.titleTextColor,
              fontWeight: FontWeight.bold,
            ),
            headline2: TextStyle(
                fontSize: 18,
                color: MyColors.subTitleTextColor,
                fontWeight: FontWeight.w400,
                wordSpacing: 1.2,
                height: 1.2),
            headline3: TextStyle(
              fontSize: 18,
              color: MyColors.titleTextColor,
              fontWeight: FontWeight.bold,
            ),
            headline4: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )),
      home: onboardingComplete ? const SplashScreen() : const onBoardingScreenHome(),
    );
  }
}
