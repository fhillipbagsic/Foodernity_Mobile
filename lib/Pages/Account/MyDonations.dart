import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Classes/Donation.dart';
import 'package:foodernity_mobile/Pages/Account/DonationItem.dart';
import 'package:foodernity_mobile/Services/Donation.dart';
import 'package:sizer/sizer.dart';

class MyDonations extends StatefulWidget {
  const MyDonations({Key? key}) : super(key: key);

  @override
  State<MyDonations> createState() => _MyDonationsState();
}

class _MyDonationsState extends State<MyDonations> {
  late Future<List<Donation>> futureDonations;
  late List<Donation> donationItems = [];

  Future<List<Donation>> getDonations() async {
    Response response;
    response = await DonationService().getDonations();

    List<Donation> donations = [];
    for (var donation in response.data['value']) {
      donations.add(Donation.fromJSON(donation));
      donationItems.add(Donation.fromJSON(donation));
    }
    setState(() {});
    return donations;
  }

  @override
  void initState() {
    super.initState();
    futureDonations = getDonations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: futureDonations,
          builder: ((context, AsyncSnapshot snapshot) {
            Widget donationsSliverList;
            if (snapshot.hasData) {
              donationsSliverList = SliverToBoxAdapter(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.5.w),
                  child: Column(
                    children: donationItems
                        .map((item) => DonationItem(donation: item))
                        .toList(),
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
