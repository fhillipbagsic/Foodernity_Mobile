import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Services/Signinup.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sizer/sizer.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String signupError = '';
  final _formKey = GlobalKey<FormState>();

  var fullNameController = TextEditingController();
  var emailAddressController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          color: Colors.blue,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(
                  'Sign up to Foodernity',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 5.h),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _field('Full Name', fullNameController),
                        SizedBox(
                          height: 2.h,
                        ),
                        _field('Email Address', emailAddressController),
                        _field('Password', passwordController),
                        SizedBox(
                          height: 2.h,
                        ),
                        _confirmPasswordField(),
                        _agreement(),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          signupError,
                          style: const TextStyle(color: Colors.red),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        _signupButton(),
                        SizedBox(
                          height: 3.h,
                        ),
                        _hasAccount()
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget _field(
    String fieldName,
    TextEditingController controller,
  ) {
    return TextFormField(
      controller: controller,
      // onSaved: (value) => controller.value = value,
      validator: fieldName == 'Full Name'
          ? fullNameValidator
          : fieldName == 'Email Address'
              ? emailAddressValidator
              : passwordValidator,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: fieldName,
        labelStyle: TextStyle(fontSize: 12.sp),
        helperText: getHelperText(fieldName),
        suffixIcon: IconButton(
          onPressed: () => controller.clear(),
          icon: Icon(
            Icons.clear,
            size: 13.sp,
          ),
        ),
      ),
      obscureText: fieldName == 'Password' ? true : false,
    );
  }

  Widget _confirmPasswordField() {
    return TextFormField(
      controller: confirmPasswordController,
      validator: (val) => MatchValidator(errorText: 'Passwords do not match')
          .validateMatch(
              confirmPasswordController.text, passwordController.text),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Confirm Password',
        labelStyle: TextStyle(fontSize: 12.sp),
        helperText: getHelperText('Confirm Password'),
        suffixIcon: IconButton(
          onPressed: () => confirmPasswordController.clear(),
          icon: Icon(
            Icons.clear,
            size: 13.sp,
          ),
        ),
      ),
      obscureText: true,
    );
  }

  final fullNameValidator = MultiValidator([
    RequiredValidator(errorText: 'Full name is required'),
    PatternValidator(r'^[a-zA-Z ]+$', errorText: 'Only letters are allowed'),
    MinLengthValidator(3, errorText: 'Please enter your full name')
  ]);

  final emailAddressValidator = MultiValidator([
    RequiredValidator(errorText: "Email address is required"),
    EmailValidator(errorText: "Enter valid email address"),
  ]);

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
    PatternValidator(r'^[a-zA-Z0-9]+$',
        errorText: 'Password must not have special character')
  ]);

  String getHelperText(String fieldName) {
    switch (fieldName) {
      case 'Full Name':
        return 'First Name, Last Name';
      case 'Password':
        return 'Must be at least 8 characters long';
    }
    return '';
  }

  Widget _agreement() {
    return (RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text:
              'By signing up for an account, you agree that you have read and accepted our ',
          style: TextStyle(color: Colors.grey),
          children: [
            TextSpan(
              text: 'Data Privacy Policy.',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ]),
    ));
  }

  Widget _signupButton() {
    void postSignup() async {
      Response response;
      response = await SignupService().signup(fullNameController.text,
          emailAddressController.text, passwordController.text);

      if (response.data == 'Success') {
        //final prefs = await SharedPreferences.getInstance();
        //await prefs.setString('emailAddress', emailAddressController.text);
        signupError = '';
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 1),
            content: Text(
              'Signing up',
              textAlign: TextAlign.center,
            ),
          ),
        );
        Timer(const Duration(seconds: 2), () => Navigator.pop(context));
      } else if (response.data == 'Taken') {
        signupError = 'Email already taken';
      } else {
        signupError = 'Something has occurred. Please restart application';
      }
      setState(() {});
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            postSignup();
          }
        },
        child: const Text('SIGN UP'),
      ),
    );
  }

  Widget _hasAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: TextStyle(color: Colors.grey, fontSize: 11.sp),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            "Sign in here",
            style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 11.sp),
          ),
        ),
      ],
    );
  }
}
