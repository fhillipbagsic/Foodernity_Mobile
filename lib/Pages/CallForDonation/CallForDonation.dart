import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CallForDonation extends StatefulWidget {
  const CallForDonation({Key? key}) : super(key: key);

  @override
  State<CallForDonation> createState() => _CallForDonationState();
}

class _CallForDonationState extends State<CallForDonation> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: ((context, snapshot) {
        Widget announcementSliverList;
        if (snapshot.hasData) {
        } else {
          announcementSliverList = const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return const CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
                automaticallyImplyLeading: false,
                largeTitle: Text('Call for Donations'))
          ],
        );
      }),
    );
  }
}
