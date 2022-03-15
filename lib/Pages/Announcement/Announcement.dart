import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Classes/Announcement.dart';
import 'package:foodernity_mobile/Pages/Announcement/AnnouncementItem.dart';
import 'package:foodernity_mobile/Services/Announcement.dart';
import 'package:sizer/sizer.dart';

class Announcement extends StatefulWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  late Future<bool> futureAnnouncements;
  List<AppAnnouncement> announcements = [];

  @override
  void initState() {
    super.initState();
    futureAnnouncements = getAnnouncements();
  }

  Future<bool> getAnnouncements() async {
    Response response;

    response = await AnnouncementService().getAnnouncements();

    if (response.data['status'] == 'ok') {
      for (var announcement in response.data['value']) {
        announcements.add(AppAnnouncement.fromJSON(announcement));
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureAnnouncements,
      builder: ((context, snapshot) {
        Widget announcementSliverList;
        if (snapshot.hasData) {
          announcementSliverList = SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 1.h, left: 2.5.w, right: 2.5.w),
              child: Column(
                children: announcements
                    .map((e) => AnnouncementItem(announcement: e))
                    .toList(),
              ),
            ),
          );
        } else {
          announcementSliverList = SliverToBoxAdapter(
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
                largeTitle: Text('Announcements'),
              ),
              announcementSliverList
            ],
          ),
        );
      }),
    );
  }
}
