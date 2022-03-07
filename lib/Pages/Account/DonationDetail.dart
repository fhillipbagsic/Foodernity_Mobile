import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Classes/Donation.dart';
import 'package:sizer/sizer.dart';

class DonationDetail extends StatelessWidget {
  final Donation donation;
  const DonationDetail({Key? key, required this.donation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text('Donation Details'),
      ),
      body: SafeArea(
          child: Container(
        child: SingleChildScrollView(
            child: Column(
          children: [
            _donationImage(donation.donationImage),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 2.h, left: 5.w, right: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _donationName(donation.donationName),
                ],
              ),
            )
          ],
        )),
      )),
    );
  }

  Widget _donationImage(String donationImage) {
    return Image.network(
      donationImage,
      width: double.infinity,
      height: 25.h,
      fit: BoxFit.fill,
    );
  }

  Widget _donationName(String donationName) {
    return Text(
      donationName,
      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
    );
  }
}
