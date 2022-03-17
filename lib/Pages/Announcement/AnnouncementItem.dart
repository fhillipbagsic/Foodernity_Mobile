import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Pages/Announcement/AnnouncementDetail.dart';
import 'package:sizer/sizer.dart';

import '../../Classes/Announcement.dart';

class AnnouncementItem extends StatelessWidget {
  final AppAnnouncement announcement;
  const AnnouncementItem({Key? key, required this.announcement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => AnnouncementDetail(
                    announcement: announcement,
                  )),
            ),
          )),
      child: Card(
        child: Column(
          children: [
            _image(announcement.documentation),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title(announcement.title),
                  _remarks(announcement.remarks),
                  _date(announcement.date),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _image(String documentation) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Image.network(
        documentation,
        height: 40.h,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _title(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.start,
    );
  }

  Widget _remarks(String remarks) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        remarks,
        style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[600],
            overflow: TextOverflow.ellipsis),
        maxLines: 2,
      ),
    );
  }

  Widget _date(String date) {
    final parsed = DateTime.parse(date);
    String formatted = getMonth(parsed.month) +
        ' ' +
        parsed.day.toString() +
        ', ' +
        parsed.year.toString();

    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        formatted,
        style: TextStyle(fontSize: 10.5.sp, color: Colors.grey[600]),
      ),
    );
  }
}
