import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodernity_mobile/Assets/my_flutter_app_icons.dart';
import 'package:foodernity_mobile/Pages/Home.dart';
import 'package:foodernity_mobile/Pages/Signinup/ForgotPassword.dart';
import 'package:foodernity_mobile/Pages/Signinup/Signup.dart';
import 'package:foodernity_mobile/Services/Announcement.dart';
import 'package:foodernity_mobile/Services/Signinup.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String signinError = '';
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailAddressController =
      TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      _googleSignIn(),
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

  Widget _noAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don???t have an account? ",
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

  Widget _googleSignIn() {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    Future<void> _handleSignIn() async {
      final prefs = await SharedPreferences.getInstance();
      try {
        await _googleSignIn.signIn().then((value) async {
          print(value?.displayName);

          Response response = await SignupService().googlesignin(
              value?.displayName,
              value?.email,
              value?.photoUrl,
              'Google',
              'Google');

          if (response.data['status'] == 'ok') {
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
          } else {
            setState(() {
              signinError = response.data['value'];
            });
          }
        });
      } on PlatformException catch (error) {
        setState(() {
          signinError = error.message as String;
        });
        print(error);
        return;
      }
    }

    return Container(
      width: double.infinity,
      child: ElevatedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            _handleSignIn();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                MyFlutterApp.google,
                color: Colors.blue,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'SIGN IN WITH GOOGLE',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          )),
    );
  }
}
/**
 
 */
// class GoogleButton extends StatefulWidget {
//   const GoogleButton({Key? key}) : super(key: key);

//   @override
//   _GoogleButtonState createState() => _GoogleButtonState();
// }

// class _GoogleButtonState extends State<GoogleButton> {
//   @override
//   late GoogleSignInAccount _userObj;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   String err = '';
//   String? name = '';
//   String? email = '';
//   String? pic = '';
//   String? test = 'test';

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Text(err),
//           Text(
//             name as String,
//             style: TextStyle(color: Colors.black),
//           ),
//           Text(email as String, style: TextStyle(color: Colors.black)),
//           Text(pic as String, style: TextStyle(color: Colors.black)),
//           Text(test as String, style: TextStyle(color: Colors.black)),
//           (OutlinedButton(
//               onPressed: () {
//                 _googleSignIn.signOut().then((userData) async {
//                   _userObj = userData!;
//                   final prefs = await SharedPreferences.getInstance();
//                   setState(() {});
//                   Response response = await SignupService().googlesignin(
//                       _userObj.displayName,
//                       _userObj.email,
//                       _userObj.photoUrl,
//                       'Google Sign-in',
//                       'Google');
//                   setState(() {
//                     name = _userObj.displayName;
//                     email = _userObj.email;
//                     pic = _userObj.photoUrl;
//                     test = 'test1';
//                   });

//                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                     duration: Duration(milliseconds: 500),
//                     content: Text(
//                       'Signing in',
//                       textAlign: TextAlign.center,
//                     ),
//                   ));

//                   if (response.data['status'] == 'ok') {
//                     await prefs.setString(
//                         'emailAddress', response.data['value']);
//                   }

//                   Timer(
//                       const Duration(seconds: 1),
//                       () => Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: ((context) => const Home()),
//                             ),
//                           ));
//                 }).catchError((e) {
//                   setState(() {
//                     err = e;
//                   });
//                   print(e);
//                 });
//                 _googleSignIn.signIn().then((userData) async {
//                   _userObj = userData!;
//                   final prefs = await SharedPreferences.getInstance();

//                   Response response = await SignupService().googlesignin(
//                       _userObj.displayName,
//                       _userObj.email,
//                       _userObj.photoUrl,
//                       'Google Sign-in',
//                       'Google');
//                   setState(() {
//                     name = _userObj.displayName;
//                     email = _userObj.email;
//                     pic = _userObj.photoUrl;
//                     test = 'test2';
//                   });
//                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                     duration: Duration(milliseconds: 500),
//                     content: Text(
//                       'Signing in',
//                       textAlign: TextAlign.center,
//                     ),
//                   ));

//                   if (response.data['status'] == 'ok') {
//                     await prefs.setString(
//                         'emailAddress', response.data['value']);
//                   }

//                   Timer(
//                       const Duration(seconds: 1),
//                       () => Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: ((context) => const Home()),
//                             ),
//                           ));
//                 }).catchError((e) {
//                   setState(() {
//                     err = e;
//                   });
//                   print(e);
//                 });
//               },
//               style: OutlinedButton.styleFrom(
//                   side: const BorderSide(color: Colors.grey)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 // ignore: prefer_const_literals_to_create_immutables
//                 children: [
//                   const SizedBox(
//                     width: 10.0,
//                   ),
//                   const Text(
//                     'SIGN IN WITH GOOGLE',
//                     style: TextStyle(color: Colors.grey),
//                   )
//                 ],
//               ))),
//         ],
//       ),
//     );
//   }
// }
