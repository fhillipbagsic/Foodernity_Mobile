import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Announcement extends StatefulWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Text('Announcement')),
    );
  }
}
