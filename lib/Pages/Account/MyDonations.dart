import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyDonations extends StatefulWidget {
  const MyDonations({Key? key}) : super(key: key);

  @override
  State<MyDonations> createState() => _MyDonationsState();
}

class _MyDonationsState extends State<MyDonations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          builder: ((context, snapshot) {
            Widget donationsSliverList;
            if (snapshot.hasData) {
              donationsSliverList = SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                  child: Column(
                    children: [],
                  ),
                ),
              );
            } else {
              donationsSliverList = SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(top: 5.h),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
            return Container(
              color: Colors.grey[100],
              child: CustomScrollView(
                slivers: [
                  const CupertinoSliverNavigationBar(
                    largeTitle: Text('My Donations'),
                  ),
                  donationsSliverList
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
