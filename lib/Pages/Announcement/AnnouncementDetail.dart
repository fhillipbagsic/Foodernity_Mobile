import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Classes/Announcement.dart';
import 'package:foodernity_mobile/Classes/DonatedItem.dart';
import 'package:sizer/sizer.dart';

class AnnouncementDetail extends StatelessWidget {
  final AppAnnouncement announcement;
  const AnnouncementDetail({Key? key, required this.announcement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text('Announcement Details'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            _image(announcement.documentation),
            _title(announcement.title),
            _beneficiaries(announcement.beneficiaries),
            _date(announcement.date),
            _remarks(announcement.remarks),
            _itemsDonated(announcement.itemsDonated)
          ],
        ),
      )),
    );
  }

  Widget _image(String image) {
    return Container(
      color: Colors.grey[200],
      child: Image.network(
        image,
        width: double.infinity,
        height: 40.h,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _title(String title) {
    return Container(
      margin: EdgeInsets.only(
        left: 5.w,
        right: 5.w,
        top: 15,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _beneficiaries(String beneficiaries) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.5.w),
      child: ListTile(
          leading: Icon(
            Icons.volunteer_activism_rounded,
            size: 20.sp,
            color: Colors.blue[500],
          ),
          horizontalTitleGap: 0,
          title: Column(
            children: [
              Text(
                'Donated to ' + beneficiaries,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue[500]),
              ),
            ],
          )),
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
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      alignment: Alignment.centerLeft,
      child: Text(
        'Donated on ' + formatted,
        style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 11.sp,
            color: Colors.grey[500]),
      ),
    );
  }

  Widget _remarks(String remarks) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Organization\'s Remarks',
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                remarks,
                style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey[900],
                    letterSpacing: .2,
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemsDonated(List items) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Items donated from Donors',
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
          ),
          Column(children: items.map((item) => _item(item)).toList())
        ],
      ),
    );
  }

  Widget _item(DonatedItem item) {
    String donor = '';

    if (item.hidden) {
      donor = 'A donor has donated ' +
          item.quantity +
          ' piece/s of ' +
          item.foodCategory;
    } else {
      donor = item.fullName +
          ' has donated ' +
          item.quantity +
          ' piece/s of ' +
          item.foodCategory;
    }
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            item.donationImage,
            width: 5.h,
            height: 5.h,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(donor, style: TextStyle(fontSize: 11.sp)),
      ),
    );
  }
}

String getMonth(int month) {
  switch (month) {
    case 1:
      return 'January';

    case 2:
      return 'February';
    case 3:
      return 'March';

    case 4:
      return 'April';

    case 5:
      return 'May';

    case 6:
      return 'June';

    case 7:
      return 'July';

    case 8:
      return 'August';

    case 9:
      return 'September';

    case 10:
      return 'October';
    case 11:
      return 'November';

    case 12:
      return 'December';
    default:
      return '';
  }
}
