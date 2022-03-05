import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Pages/Signinup/Signin.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Sizer(builder: ((context, orientation, deviceType) {
          return const Scaffold(
            body: SafeArea(
              child: Signin(),
            ),
          );
        })));
  }
}
