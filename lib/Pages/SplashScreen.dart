import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.blue,
        child: const Center(
            child: Text(
          'Foodernity',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        )),
      )),
    );
  }
}
