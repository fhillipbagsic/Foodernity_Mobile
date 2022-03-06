import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class MakeDonation extends StatefulWidget {
  const MakeDonation({Key? key}) : super(key: key);

  @override
  State<MakeDonation> createState() => _MakeDonationState();
}

class _MakeDonationState extends State<MakeDonation> {
  File? donationImage;
  TextEditingController donationName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.grey[200],
        child: CustomScrollView(slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Make a Donation'),
          ),
          _donationImage()
        ]),
      )),
    );
  }

  Widget _donationImage() {
    Future<void> uploadImage() async {
      // final picker = ImagePicker();
      // final pickedImage = await picker.pickImage(source: ImageSource.gallery);

      // if (pickedImage != null && pickedImage.path != '') {
      //   setState(() {
      //     donationImage = File(pickedImage.path);
      //   });
      // }
    }

    return SliverToBoxAdapter(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
          child: Text('Picture of your donation',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp)),
        ),
        Container(
          margin: EdgeInsets.only(left: 5.w, right: 5.w),
          height: 20.h,
          width: double.infinity,
          child: Card(
            child: donationImage == null
                ? Center(
                    child: ElevatedButton(
                    onPressed: () {
                      uploadImage();
                    },
                    child: Text('Upload an image'),
                  ))
                : Text('has image'),
          ),
        )
      ]),
    );
  }
}
