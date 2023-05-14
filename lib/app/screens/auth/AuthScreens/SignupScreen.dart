import 'package:firebase_auth/firebase_auth.dart';
import 'package:flarezchat/app/screens/auth/AuthScreens/SigninScreen.dart';
import 'package:flutter/material.dart';
import 'package:flarezchat/app/screens/auth/components/my_textfield.dart';
import 'package:flarezchat/app/screens/auth/components/square_tile.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/HomeScreen.dart';
import '../components/signup_my_button.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // text editing controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user up method
  void signUserUp() {}

  @override
  void dispose() {
    // dispose of controllers when the widget is disposed
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                    Icons.person_add,
                    size: 70,
                  ),
                ),

                const SizedBox(height: 50),

                Text(
                  'Create an account to get started!',
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
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // email textfield
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

                const SizedBox(height: 25),

                // sign up button
                MyButton(
                  text: 'Sign Up',
                  onTap: Create_Account,
                ),

                const SizedBox(height: 30),

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

                const SizedBox(height: 30),

                // google + apple + facebook sign up buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // google button
                    SquareTile(imagePath: 'assets/images/google.png'),

                    SizedBox(width: 25),

                    // apple button
                    SquareTile(imagePath: 'assets/images/apple.png'),

                    SizedBox(width: 25),

                    // facebook button
                    SquareTile(imagePath: 'assets/images/facebook.png'),
                  ],
                ),

                const SizedBox(height: 50),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 100),
                        pageBuilder: (_, __, ___) => LoginPage(),
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
                        'Already have an Account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Signin now',
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

  Future<void> Create_Account() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Validate email
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sign Up Error'),
          content: Text('Please enter a valid email address.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // Validate password
    final passwordRegex = RegExp(r'^(?=.*?[A-Za-z])(?=.*?[0-9]).{8,}$');
    if (!passwordRegex.hasMatch(password)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sign Up Error'),
          content: Text('Password must be at least 8 characters long and contain at least one letter and one number.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      final UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userId = userCredential.user!.uid;
      // Store user id in persistent storage
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('userId', userId);
      // if sign up successful, navigate to home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Error creating user account';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Sign Up Error'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
