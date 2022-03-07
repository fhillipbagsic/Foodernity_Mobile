import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Donated extends StatelessWidget {
  final String donationName;
  const Donated({Key? key, required this.donationName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Image.asset(
              'lib/Assets/donations.png',
              width: 50.w,
              height: 25.h,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'Thank You!',
              style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'Please wait for the organization to accept your donation. You will be notified once accepted so you can proceed to deliver your donation.',
              style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color.fromRGBO(111, 111, 111, 1)),
              textAlign: TextAlign.center,
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.popUntil(context, (route) => route.isFirst),
                    child: Text(
                      'GO TO HOME',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  )),
            ))
          ],
        ),
      )),
    );
  }
}
