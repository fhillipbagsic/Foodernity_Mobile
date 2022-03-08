import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Classes/CallForDonation.dart';
import 'package:foodernity_mobile/Pages/CallForDonation/CallForDonationItem.dart';
import 'package:foodernity_mobile/Services/CallForDonation.dart';
import 'package:sizer/sizer.dart';

class CallForDonation extends StatefulWidget {
  const CallForDonation({Key? key}) : super(key: key);

  @override
  State<CallForDonation> createState() => _CallForDonationState();
}

class _CallForDonationState extends State<CallForDonation> {
  late Future<bool> futureCallForDonations;
  late List<CallforDonation> callForDonations = [];

  @override
  void initState() {
    super.initState();
    futureCallForDonations = getCallForDonations();
  }

  Future<bool> getCallForDonations() async {
    Response response;
    response = await CallForDonationService().getCallForDonations();

    for (var callfordonation in response.data['value']) {
      callForDonations.add(CallforDonation.fromJSON(callfordonation));
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureCallForDonations,
      builder: ((context, snapshot) {
        Widget callForDonationSliverList;
        if (snapshot.hasData) {
          callForDonationSliverList = SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 1.h, left: 2.5.w, right: 2.5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: callForDonations
                    .map((item) => CallForDonationItem(item: item))
                    .toList(),
              ),
            ),
          );
        } else {
          callForDonationSliverList = SliverToBoxAdapter(
            child: Container(
                margin: EdgeInsets.only(top: 2.h),
                child: const Center(child: CircularProgressIndicator())),
          );
        }
        return Container(
          color: Colors.grey[200],
          child: CustomScrollView(
            slivers: [
              const CupertinoSliverNavigationBar(
                automaticallyImplyLeading: false,
                largeTitle: Text('Call for Donations'),
              ),
              callForDonationSliverList
            ],
          ),
        );
      }),
    );
  }
}
