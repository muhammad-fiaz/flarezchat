import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../intro/splash/SplashScreen.dart';

// This Will display the internet Connection Not Available Page
class NoInternetConnectionPage extends StatelessWidget {
  final VoidCallback onRetry;

  const NoInternetConnectionPage({Key? key, required this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.signal_wifi_off,
              size: 50,
            ),
            SizedBox(height: 20),
            Text(
              'No internet connection available',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var connectivityResult = await (Connectivity().checkConnectivity());
                if (connectivityResult != ConnectivityResult.none) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SplashScreen()),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('No Internet Connection'),
                        content: Text('Please check your internet connection and try again.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
