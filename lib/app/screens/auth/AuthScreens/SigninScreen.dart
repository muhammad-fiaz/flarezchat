import 'package:firebase_auth/firebase_auth.dart';
import 'package:flarezchat/app/screens/auth/AuthScreens/SignupScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flarezchat/app/screens/auth/components/my_textfield.dart';
import 'package:flarezchat/app/screens/auth/components/square_tile.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../pages/HomeScreen.dart';
import '../components/my_button.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: 2),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 70,
                  ),
                ),


                const SizedBox(height: 50),

                Text(
                  'Welcome back! Sign in to get started!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.italic,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 25),

                // username textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // sign in button
                MyButton(
                  onTap: () => signUserIn_auth(context), // Pass the BuildContext to the method
                ),

                const SizedBox(height: 50),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

// google + apple + facebook sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    // google button
                    GestureDetector(
                      onTap: () => showComingSoonMessage(context),
                      child: SquareTile(imagePath: 'assets/images/google.png'),
                    ),

                    SizedBox(width: 25),

                    // apple button
                    GestureDetector(
                      onTap: () => showComingSoonMessage(context),
                      child: SquareTile(imagePath: 'assets/images/apple.png'),
                    ),

                    SizedBox(width: 25),

                    // facebook button
                    GestureDetector(
                      onTap: () => showComingSoonMessage(context),
                      child: SquareTile(imagePath: 'assets/images/facebook.png'),
                    ),
                  ],
                ),


                const SizedBox(height: 50),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 100),
                        pageBuilder: (_, __, ___) => SignUpPage(),
                        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )


              ],
            ),
          ),
        ),
      ),
    );

  }
  void showComingSoonMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Coming Soon'),
          content: const Text('This feature will be available soon.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
  /*
  void signUserIn_auth(BuildContext context) async {
    try {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      // Validate email and password (you can add your own validation logic)

      // Sign in the user with email and password
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigate to the homepage if sign-in is successful
      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } catch (e) {
      // Handle sign-in errors
      print(e.toString());
      // Show error message to the user (you can use a dialog, SnackBar, etc.)
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sign-in Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }
*/
  void signUserIn_auth(BuildContext context) async {
    try {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

          // Validate email and password
          if (email.isEmpty || password.isEmpty) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Validation Error'),
                content: Text('Email and password cannot be empty.'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            );
            return;
          }
      // Sign in the user with email and password
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigate to the homepage if sign-in is successful
      final user = userCredential.user;
      if (user != null) {
        // Store user ID and email in persistent storage
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userId', user.uid);
        prefs.setString('email', email);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } catch (e) {
      // Handle sign-in errors
      print(e.toString());

      String errorMessage = 'An unknown error occurred.';
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'invalid-email':
            errorMessage = 'Invalid email address.';
            break;
          case 'user-disabled':
            errorMessage = 'This account has been disabled.';
            break;
          case 'user-not-found':
            errorMessage = 'User not found. Please check your email and password.';
            break;
          case 'wrong-password':
            errorMessage = 'Invalid password. Please check your email and password.';
            break;
          default:
            errorMessage = 'Sign-in failed. Please try again later.';
            break;
        }
      }
// this will show the exception when its occurs
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sign-in Error'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(errorMessage),
              SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: 'If you think this is a mistake, ',
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'contact support',
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          final Uri websiteLaunchUri = Uri(
                            scheme: 'https',  // for mail => scheme: 'mailto',
                            path: 'github.com/muhammad-fiaz', //  path: 'support@example.com',
                            queryParameters: {'subject': 'Sign-in Error'},
                          );
                          if (await canLaunch(websiteLaunchUri.toString())) {
                            await launch(websiteLaunchUri.toString());
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Error'),
                                content: Text('Failed to launch the URL.'),
                                actions: [
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                    ),
                    TextSpan(text: ' for assistance.'),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

}
