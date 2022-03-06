import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ResetPassword extends StatefulWidget {
  final String emailAddress;
  const ResetPassword({Key? key, required this.emailAddress}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
        child: Column(
          children: [Text('Reset password')],
        ),
      )),
    );
  }
}
