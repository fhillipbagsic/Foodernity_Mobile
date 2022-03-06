import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Pages/Signinup/ResetPassword.dart';
import 'package:foodernity_mobile/Pages/Signinup/Signin.dart';
import 'package:foodernity_mobile/Services/Signinup.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sizer/sizer.dart';

class EnterCode extends StatefulWidget {
  final String emailAddress;

  const EnterCode({Key? key, required this.emailAddress}) : super(key: key);

  @override
  State<EnterCode> createState() => _EnterCodeState();
}

class _EnterCodeState extends State<EnterCode> {
  String codeError = '';

  final _formKey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();

  String maskEmailAddress(String emailAddress) {
    String front = emailAddress.substring(0, 3);
    String asterisks = '';

    for (int i = 0; i < emailAddress.length - 7; i++) {
      asterisks += '*';
    }
    String end = emailAddress.substring(emailAddress.length - 4);

    return front + asterisks + end;
  }

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
                'Enter code',
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                'A verification code has been to your email address: ' +
                    maskEmailAddress(widget.emailAddress) +
                    '. Please enter the code to continue.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              codeError == ''
                  ? const SizedBox()
                  : Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 3.h),
                      child: Text(
                        codeError,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: codeController,
                      validator: codeValidator,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Code',
                        suffixIcon: IconButton(
                          onPressed: () => codeController.clear(),
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
                    _confirmCodeButton(),
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

  Widget _confirmCodeButton() {
    void postConfirmCode() async {
      Response response;

      response = await SignupService()
          .confirmCode(widget.emailAddress, codeController.text);

      if (response.data['status'] == 'error') {
        codeError = response.data['value'];
      } else {
        codeError = '';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ResetPassword(emailAddress: widget.emailAddress),
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
            postConfirmCode();
          }
        },
        child: Text('CONFIRM CODE', style: TextStyle(fontSize: 11.sp)),
      ),
    );
  }

  Widget _backButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.popUntil(context, (route) => route.isFirst);
        },
        child: Text('BACK TO SIGNIN', style: TextStyle(fontSize: 11.sp)),
      ),
    );
  }

  final codeValidator = MultiValidator([
    RequiredValidator(errorText: "Please enter the code"),
    MinLengthValidator(6, errorText: 'Code must be at least 6 digits long'),
  ]);
}
