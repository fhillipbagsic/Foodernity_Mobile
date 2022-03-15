import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Classes/Announcement.dart';

class AnnouncementDetail extends StatelessWidget {
  final AppAnnouncement announcement;
  const AnnouncementDetail({Key? key, required this.announcement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      )),
    );
  }
}
