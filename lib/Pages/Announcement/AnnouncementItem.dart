import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Classes/Announcement.dart';

class AnnouncementItem extends StatelessWidget {
  final AppAnnouncement announcement;
  const AnnouncementItem({Key? key, required this.announcement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.network(
              announcement.documentation,
              height: 40.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [Text(announcement.title)],
            ),
          )
        ],
      ),
    );
  }
}
