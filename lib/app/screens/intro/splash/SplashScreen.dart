import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flarezchat/app/screens/auth/AuthScreens/SigninScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/HomeScreen.dart';

/*
  Project: Flarez Chat
  Author: Muhammad Fiaz
  GitHub: https://github.com/muhammad-fiaz
*/
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _controller.forward();
    checkConnectivity();
  }
// This will Check if the Internet Connection is Available During Splash Screen
  Future<void> checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final email = prefs.getString('email');

    if (connectivityResult == ConnectivityResult.none) {
      if (userId != null && email != null) {
        // Check if the stored credentials are valid in Firebase
        // If valid, navigate to the home page with a fade-in animation
        // Otherwise, navigate to the login page with a fade-in animation
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 300),
            pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
              opacity: animation,
              child: HomePage(),
            ),
          ),
        );
      } else {
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 300),
            pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
              opacity: animation,
              child: LoginPage(),
            ),
          ),
        );
      }
    } else {
      Future.delayed(Duration(seconds: 3)).then((value) {
        if (userId != null && email != null) {
          // Check if the stored credentials are valid in Firebase
          // If valid, navigate to the home page with a fade-in animation
          // Otherwise, navigate to the login page with a fade-in animation
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 300),
              pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
                opacity: animation,
                child: HomePage(),
              ),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 300),
              pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
                opacity: animation,
                child: LoginPage(),
              ),
            ),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[600]!,
              Colors.purple[600]!,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _controller,
                child: Icon(
                  Icons.chat_bubble_outline,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              FadeTransition(
                opacity: _controller,
                child: TypewriterAnimatedTextKit(
                  speed: const Duration(milliseconds: 100),
                  isRepeatingAnimation: false,
                  textStyle: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                  text: ['Flarez Chat'],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
