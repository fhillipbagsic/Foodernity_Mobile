import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Pages/Home.dart';
import 'package:foodernity_mobile/Pages/Signinup/ForgotPassword.dart';
import 'package:foodernity_mobile/Pages/Signinup/Signup.dart';
import 'package:foodernity_mobile/Services/Signinup.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String signinError = '';
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailAddressController =
      TextEditingController(text: 'fcbagsic@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: 'may202000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                      signinError == ''
                          ? const SizedBox()
                          : Text(
                              signinError,
                              style: const TextStyle(color: Colors.red),
                            ),
                      SizedBox(
                        height: 2.h,
                      ),
                      _field('Email Address', emailAddressController),
                      SizedBox(
                        height: 2.h,
                      ),
                      _field('Password', passwordController),
                      SizedBox(
                        height: 2.h,
                      ),
                      _forgotPassword(),
                      SizedBox(
                        height: 3.h,
                      ),
                      _signinButton(),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      const Text(
                        'or',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      _googleSigninButton(),
                      SizedBox(
                        height: 4.h,
                      ),
                      _noAccount()
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(
    String fieldName,
    TextEditingController controller,
  ) {
    return TextFormField(
      controller: controller,
      validator: fieldName == 'Email Address'
          ? emailAddressValidator
          : passwordValidator,
      autocorrect: false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: fieldName,
        labelStyle: TextStyle(fontSize: 12.sp),
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

  Widget _forgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ForgotPassword(),
            ),
          ),
          child: Text(
            "Forgot Password? ",
            style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 11.sp),
          ),
        ),
      ],
    );
  }

  Widget _signinButton() {
    void postSignin() async {
      final prefs = await SharedPreferences.getInstance();
      Response response;
      response = await SignupService()
          .signin(emailAddressController.text, passwordController.text);
      if (response.data['status'] == 'error') {
        signinError = response.data['value'];
      } else {
        signinError = '';
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 500),
            content: Text(
              'Signing in',
              textAlign: TextAlign.center,
            ),
          ),
        );

        await prefs.setString('emailAddress', response.data['value']);

        //RESET TOKEN ON LOGOUT
        Timer(
            const Duration(seconds: 1),
            () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const Home()),
                  ),
                ));
      }
      setState(() {});
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            postSignin();
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(const SnackBar(content: Text('Signing in')));

          }
        },
        child: Text('SIGN IN', style: TextStyle(fontSize: 11.sp)),
      ),
    );
  }

  Widget _googleSigninButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          'SIGN IN WITH GOOGLE',
          style: TextStyle(fontSize: 11.sp),
        ),
      ),
    );
  }

  Widget _noAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: TextStyle(color: Colors.grey, fontSize: 11.sp),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Signup()));
          },
          child: Text(
            "Sign up here",
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
