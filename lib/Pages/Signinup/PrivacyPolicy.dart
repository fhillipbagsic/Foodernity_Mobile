import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

String introDescription =
    "Foodernity is a mobile application intented to serve as a donation platform that will bridge food donors, organizations, and beneficiaries. Through this application, redistributing excess food helps lessen the food waste while ensuring food security for beneficiaries' households. The data sent over the web server are managed by the developers and is stored in a third-party database. The processed data will be used by Most Holy Trinity Parish - Food Bank, an organization operating in Manila. These data will only be used within the application.";

String a =
    "The application only collects the basic contact information of users. These data will only be used as the reference for the data posted in the mobile application, such as who made the donations. \n• User's full name; \n• User's email address. Optionally, users can upload any kind of profile picture and in the case of users uploading their real image, the image is stored in a third-party image hosting site.";
String b = "";
String c = '';
String d = '';
String e = '';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: CustomScrollView(
          slivers: [
            const CupertinoSliverNavigationBar(
              largeTitle: Text('Data Privacy Policy'),
            ),
            _title('Introduction'),
            _description(introDescription),
            _title('A. Processing of Your Personal Data'),
            _description(a),
            _subtitle('A. What We Collect from Users'),
            _subtitle('A. What We Collect from Users'),
            _subtitle('A. What We Collect from Users'),
            _subtitle('A. What We Collect from Users'),
            _subtitle('A. What We Collect from Users'),
          ],
        ),
      )),
    );
  }

  Widget _title(String title) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Text(
          title,
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _subtitle(String subtitle) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Text(
          subtitle,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
      ),
    );
  }

  Widget _description(String description) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: Text(
          description,
          style: TextStyle(
            fontSize: 12.sp,
            height: 1.4,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
