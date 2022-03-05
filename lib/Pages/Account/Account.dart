import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
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
              largeTitle: Text('My Account'),
            )
          ],
        );
      }),
    );
    ;
  }
}
