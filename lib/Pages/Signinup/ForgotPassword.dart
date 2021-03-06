// ignore: file_names
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Pages/Signinup/EnterCode.dart';
import 'package:foodernity_mobile/Pages/Signinup/ResetPassword.dart';
import 'package:foodernity_mobile/Services/Signinup.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sizer/sizer.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String forgotPasswordError = '';
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailAddressController = TextEditingController();

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
                'Reset your password',
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                'Enter the Email associated with your account and we\'ll send a code with instructions to reset your password.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              forgotPasswordError == ''
                  ? const SizedBox()
                  : Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 3.h),
                      child: Text(
                        forgotPasswordError,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailAddressController,
                      validator: emailAddressValidator,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Email Address',
                        suffixIcon: IconButton(
                          onPressed: () => emailAddressController.clear(),
                          icon: Icon(
                            Icons.clear,
                            size: 13.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    _sendCodeButton(),
                    _backButton()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final emailAddressValidator = MultiValidator([
    RequiredValidator(errorText: "Email address is required"),
    EmailValidator(errorText: "Enter valid email address"),
  ]);

  Widget _sendCodeButton() {
    void postForgotPassword() async {
      Response response;
      response =
          await SignupService().forgotpassword(emailAddressController.text);

      if (response.data['status'] == 'error') {
        forgotPasswordError = response.data['value'];
      } else {
        forgotPasswordError = '';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EnterCode(
              emailAddress: emailAddressController.text,
            ),
          ),
        );
      }
      setState(() {});
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            postForgotPassword();
          }
        },
        child: Text('SEND CODE', style: TextStyle(fontSize: 11.sp)),
      ),
    );
  }

  Widget _backButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('BACK TO SIGNIN', style: TextStyle(fontSize: 11.sp)),
      ),
    );
  }
}
