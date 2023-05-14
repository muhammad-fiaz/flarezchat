import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flarez Chat'),
      ),
      body: const Center(
        child: Text('This is the home page still in Development'),
      ),
    );
  }
}
