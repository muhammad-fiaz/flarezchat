import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flarezchat/app/screens/auth/AuthScreens/SigninScreen.dart';
import 'package:flarezchat/app/screens/auth/components/my_textfield.dart';
import 'package:flarezchat/app/screens/auth/components/square_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/HomeScreen.dart';
import '../components/signup_my_button.dart';

/*
  Project: Flarez Chat
  Author: Muhammad Fiaz
  GitHub: https://github.com/muhammad-fiaz
*/

/// A StatefulWidget representing the sign-up page of the application.
class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

/// The state class for the SignUpPage.
class _SignUpPageState extends State<SignUpPage> {
  // Text editing controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  File? _selectedImage;

  /// Dispose of controllers when the widget is disposed.
  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// Build method for the sign-up page.
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

                // InkWell for selecting image
                InkWell(
                  onTap: _pickImageAndCrop,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 2),
                    ),
                    child: _selectedImage != null
                        ? ClipOval(
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                      ),
                    )
                        : Icon(
                      Icons.person_add,
                      size: 70,
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                // Text indicating to create an account
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

                // Username textfield
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // Email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // Password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                // Sign Up button
                MyButton(
                  text: 'Sign Up',
                  onTap: () => Create_Account(context),
                ),

                const SizedBox(height: 30),

                // Or continue with
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

                // Google + Apple + Facebook sign-up buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // Google button
                    SquareTile(imagePath: 'assets/images/google.png'),

                    SizedBox(width: 25),

                    // Apple button
                    SquareTile(imagePath: 'assets/images/apple.png'),

                    SizedBox(width: 25),

                    // Facebook button
                    SquareTile(imagePath: 'assets/images/facebook.png'),
                  ],
                ),

                const SizedBox(height: 50),

                // Already have an account? Sign in now
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

  /// Pick and crop image from the device.
  Future<void> _pickImageAndCrop() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final croppedImage = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxWidth: 700,
        maxHeight: 700,
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        iosUiSettings: IOSUiSettings(
          title: 'Crop Image',
        ),
      );

      if (croppedImage != null) {
        setState(() {
          _selectedImage = croppedImage;
        });
      }
    }
  }

  // GlobalKey for the loading dialog
  final GlobalKey<State> _loadingDialogKey = GlobalKey<State>();

  /// Show the loading dialog.
  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(
            key: _loadingDialogKey,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SpinKitCubeGrid(
                color: Colors.blue,
                size: 50,
              ),
            ),
          ),
        );
      },
    );
  }

  /// Hide the loading dialog.
  void _hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// Create an account in Firebase.
  Future<void> Create_Account(BuildContext context) async {
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
          content: Text(
            'Password must be at least 8 characters long and contain at least one letter and one number.',
          ),
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
      // Show the loading dialog
      _showLoadingDialog(context);

      final UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userId = userCredential.user!.uid;

      // Store user email and ID in persistent storage
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
      prefs.setString('userId', userId);

      // Hide the loading dialog
      _hideLoadingDialog(context);

      // Clear navigation stack and navigate to the home screen
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Error creating user account';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }
      // Hide the loading dialog
      _hideLoadingDialog(context);
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
