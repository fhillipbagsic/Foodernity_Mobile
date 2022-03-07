import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Services/Signinup.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sizer/sizer.dart';

class ResetPassword extends StatefulWidget {
  final String emailAddress;

  const ResetPassword({Key? key, required this.emailAddress}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create new password',
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              'Enter your new password below to reset your password.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: passwordController,
                    validator: passwordValidator,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'New Password',
                      labelStyle: TextStyle(fontSize: 12.sp),
                      helperText: 'Must be at least 8 characters long',
                      suffixIcon: IconButton(
                        onPressed: () => passwordController.clear(),
                        icon: Icon(
                          Icons.clear,
                          size: 13.sp,
                        ),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  TextFormField(
                    controller: confirmPasswordController,
                    validator: (val) =>
                        MatchValidator(errorText: 'Passwords do not match')
                            .validateMatch(confirmPasswordController.text,
                                passwordController.text),
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(fontSize: 12.sp),
                      suffixIcon: IconButton(
                        onPressed: () => confirmPasswordController.clear(),
                        icon: Icon(
                          Icons.clear,
                          size: 13.sp,
                        ),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  _resetPassword()
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget _resetPassword() {
    void postResetPassword() async {
      print(passwordController.text);
      Response response;
      response = await SignupService()
          .resetPassword(widget.emailAddress, passwordController.text);

      if (response.data['status'] == 'ok') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 1),
            content: Text(
              'Password successfully changed',
              textAlign: TextAlign.center,
            ),
          ),
        );
        Timer(const Duration(seconds: 2),
            () => Navigator.popUntil(context, (route) => route.isFirst));
      }
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            postResetPassword();
          }
        },
        child: const Text('RESET PASSWORD'),
      ),
    );
  }

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
    PatternValidator(r'^[a-zA-Z0-9]+$',
        errorText: 'Password must not have special character')
  ]);
}
