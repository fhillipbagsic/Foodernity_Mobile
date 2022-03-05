import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Announcement extends StatefulWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
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
              largeTitle: Text('Announcements'),
            )
          ],
        );
      }),
    );
  }
}
