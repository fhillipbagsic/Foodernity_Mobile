import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Classes/AppNotifications.dart';
import 'package:foodernity_mobile/Pages/Notifications/NotificationItem.dart';
import 'package:sizer/sizer.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late Future<List<AppNotifications>> futureNotifications;

  @override
  void initState() {
    super.initState();
    futureNotifications = getNotifications();
  }

  Future<List<AppNotifications>> getNotifications() async {
    List<AppNotifications> notifications = [];

    notifications.add(AppNotifications(
        type: 'Received',
        message:
            'Your donation Pancit Canton has been received has been received. Thank you for donating!'));

    notifications.add(AppNotifications(
        type: 'Accepted',
        message:
            'Your donation Pancit Canton has been accepted. Please do prepare to send it right away. Thank you!'));
    return notifications;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureNotifications,
      builder: ((context, AsyncSnapshot snapshot) {
        Widget notificationsSliverList;
        if (snapshot.hasData) {
          notificationsSliverList = SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return NotificationItem(notification: snapshot.data[index]);
            }, childCount: snapshot.data.length),
          );
        } else {
          notificationsSliverList = SliverToBoxAdapter(
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
                largeTitle: Text('Notifications'),
              ),
              notificationsSliverList
            ],
          ),
        );
      }),
    );
  }
}
