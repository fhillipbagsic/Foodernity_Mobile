import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late Future<Account> futureAccount;

  @override
  void initState() {
    super.initState();
    // futureNotifications = getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //future: futureAccount,
      builder: ((context, snapshot) {
        Widget announcementSliverList;
        if (snapshot.hasData) {
        } else {
          announcementSliverList = const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return Container(
          color: Colors.grey[200],
          child: const CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                automaticallyImplyLeading: false,
                largeTitle: Text('My Account'),
              )
            ],
          ),
        );
      }),
    );
    ;
  }
}
