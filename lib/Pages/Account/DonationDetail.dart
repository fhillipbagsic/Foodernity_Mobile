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
          child: SingleChildScrollView(
        child: Column(
          children: [
            _donationImage(donation.donationImage),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 2.h, left: 2.5.w, right: 2.5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _donationName(donation.donationName),
                  SizedBox(
                    height: 1.h,
                  ),
                  _status(donation.status)
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget _donationImage(String donationImage) {
    return Container(
      color: Colors.grey[200],
      child: Image.network(
        donationImage,
        width: double.infinity,
        height: 35.h,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _donationName(String donationName) {
    return Text(
      donationName,
      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
    );
  }

  Widget _status(String status) {
    String description = '';
    Color? fontColor;
    Color? borderColor;
    Color? bgColor;

    if (status == 'Pending') {
      description = '';
      fontColor = Colors.black;
      borderColor = Colors.black;
      bgColor = Colors.black;
    } else if (status == 'Accepted') {
      description =
          'You will be notified once your donation has been accepted so you can proceed to deliver it';
      fontColor = Colors.green[500];
      borderColor = Colors.green;
      bgColor = Colors.green[50];
    } else if (status == 'Received') {
      description = 'received';
      fontColor = Colors.blue[500];
      borderColor = Colors.blue;
      bgColor = Colors.blue[50];
    } else {
      description = 'declined';
      fontColor = Colors.red[500];
      borderColor = Colors.red;
      bgColor = Colors.red[50];
    }

    return Card(
      color: bgColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: ListTile(
        horizontalTitleGap: 0,
        leading: Icon(
          Icons.groups_rounded,
          size: 20.sp,
          color: fontColor,
        ),
        title: Text(
          description,
          style: TextStyle(
              fontSize: 12.sp, fontWeight: FontWeight.w500, color: fontColor),
        ),
      ),
    );
    ;
  }
}
