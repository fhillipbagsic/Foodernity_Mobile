import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
              largeTitle: Text('Notifications'),
            )
          ],
        );
      }),
    );
  }
}
