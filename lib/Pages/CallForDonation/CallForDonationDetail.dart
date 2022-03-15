import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Classes/CallForDonation.dart';
import 'package:foodernity_mobile/Pages/MakeDonation/Guidelines.dart';
import 'package:sizer/sizer.dart';

class CallForDonationDetail extends StatefulWidget {
  final CallforDonation item;
  const CallForDonationDetail({Key? key, required this.item}) : super(key: key);

  @override
  State<CallForDonationDetail> createState() => _CallForDonationDetailState();
}

class _CallForDonationDetailState extends State<CallForDonationDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text('Call for Donation Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _image(widget.item.image),
              SizedBox(
                height: 2.h,
              ),
              _title(widget.item.title),

              SizedBox(
                height: 1.h,
              ),
              _beneficiaries(widget.item.beneficiaries),
              SizedBox(
                height: 2.h,
              ),
              _remarks(widget.item.remarks),
              // _donateButton()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => Guidelines(donatedTo: widget.item.id)),
              ),
            )),
        child: const Icon(Icons.volunteer_activism_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _image(String image) {
    return Container(
      color: Colors.grey[200],
      child: Image.network(
        image,
        width: double.infinity,
        height: 55.h,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _title(String title) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      child: Text(
        title,
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _beneficiaries(String beneficiaries) {
    return Card(
      color: Colors.blue[50],
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.blue, width: 1.5),
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: ListTile(
        horizontalTitleGap: 0,
        leading: Icon(
          Icons.groups_rounded,
          size: 20.sp,
          color: Colors.blue[500],
        ),
        title: Text(
          'To be donated to ' + beneficiaries,
          style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.blue[500]),
        ),
      ),
    );
  }

  Widget _remarks(String remarks) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Organization's Remarks",
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: .5.h,
            ),
            Text(
              remarks,
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _donateButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.5.w),
      width: double.infinity,
      child: ElevatedButton(
          onPressed: (() => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => Guidelines(donatedTo: widget.item.id)),
                ),
              )),
          child: Text(
            'Donate now',
            style: TextStyle(fontSize: 11.sp),
          )),
    );
  }
}
