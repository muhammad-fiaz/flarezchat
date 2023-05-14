import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../exceptions/NoInternetConnectionPage.dart';
import '../../pages/HomeScreen.dart';

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

  Future<void> checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NoInternetConnectionPage(onRetry: () {  },)),
      );
    } else {
      Future.delayed(Duration(seconds: 3)).then((value) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      ));
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
