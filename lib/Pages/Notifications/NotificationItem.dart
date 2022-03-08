import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Classes/AppNotifications.dart';
import 'package:sizer/sizer.dart';

class NotificationItem extends StatelessWidget {
  final AppNotifications notification;

  const NotificationItem({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      child: Row(children: [
        _icon(notification.status),
        SizedBox(
          width: 2.w,
        ),
        _description(notification.status, notification.message)
      ]),
    );
  }

  Widget _icon(String status) {
    Icon icon;
    Color? bgColor;

    if (status == 'Accepted') {
      icon = const Icon(
        Icons.check_rounded,
        color: Colors.green,
      );

      bgColor = Colors.green[100];
    } else if (status == 'Received') {
      icon = const Icon(
        Icons.inventory,
        color: Colors.blue,
      );
      bgColor = Colors.blue[100];
    } else if (status == 'Donated') {
      icon = const Icon(
        Icons.volunteer_activism_rounded,
        color: Colors.brown,
      );
      bgColor = Colors.brown[100];
    } else {
      icon = const Icon(
        Icons.cancel_rounded,
        color: Colors.red,
      );
      bgColor = Colors.red[100];
    }

    return Container(
      padding: EdgeInsets.all(15.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100), color: bgColor),
      child: icon,
    );
  }

  Widget _description(String status, String message) {
    String title = "Donation " + status;
    Color color;

    if (status == 'Accepted') {
      color = Colors.green;
    } else if (status == 'Received') {
      color = Colors.blue;
    } else if (status == 'Donated') {
      color = Colors.brown;
    } else {
      color = Colors.red;
    }

    // if (type == 'Received') {
    //   title = 'Donation Received';
    //   color = Colors.blue;
    // } else {
    //   title = 'Donation Accepted';
    //   color = Colors.green;
    // }

    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 13.sp, fontWeight: FontWeight.bold, color: color),
        ),
        SizedBox(
          height: 0.5.h,
        ),
        Text(
          message,
          style: TextStyle(fontSize: 9.sp),
        )
      ],
    ));
  }
}
