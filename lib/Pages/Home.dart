import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Pages/Account/Account.dart';
import 'package:foodernity_mobile/Pages/Announcement/Announcement.dart';
import 'package:foodernity_mobile/Pages/CallForDonation/CallForDonation.dart';
import 'package:foodernity_mobile/Pages/Notifications/Notifications.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    PlaceholderWidget(const Notifications()),
    PlaceholderWidget(const Announcement()),
    PlaceholderWidget(const CallForDonation()),
    PlaceholderWidget(const Account())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _children[_currentIndex]),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Notifications'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket_rounded),
                label: 'Announcements'),
            BottomNavigationBarItem(
                icon: Icon(Icons.food_bank), label: 'Call For Donations'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'Account'),
          ]),
    );
  }

  int onTabTapped(int index) {
    setState(() => _currentIndex = index);
    print(index);
    return _currentIndex;
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Widget widget;

  PlaceholderWidget(this.widget);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget,
    );
  }
}
