import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Classes/Account.dart';
import 'package:foodernity_mobile/Pages/Account/MyDonations.dart';
import 'package:foodernity_mobile/Pages/Account/Profile.dart';
import 'package:foodernity_mobile/Pages/Signinup/Signin.dart';
import 'package:foodernity_mobile/Services/Account.dart';
import 'package:sizer/sizer.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  late Future<Account> futureAccount;

  @override
  void initState() {
    super.initState();
    // futureNotifications = getNotifications();
    futureAccount = getAccount();
  }

  Future<Account> getAccount() async {
    Response response;
    response = await AccountService().getAccount();

    return Account.fromJSON(response.data['value']);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureAccount,
      builder: ((context, AsyncSnapshot snapshot) {
        Widget accountSliverList;
        if (snapshot.hasData) {
          accountSliverList = SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
              child: Column(
                children: [
                  _profilePicture(snapshot.data.profilePicture),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  _fullName(snapshot.data.fullName),
                  SizedBox(
                    height: .5.h,
                  ),
                  _emailAddress(snapshot.data.emailAddress),
                  SizedBox(
                    height: 3.h,
                  ),
                  _pages(),
                  SizedBox(
                    height: 5.h,
                  ),
                  _logout()
                ],
              ),
            ),
          );
        } else {
          accountSliverList = SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 5.h),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        return Container(
          color: Colors.grey[100],
          child: CustomScrollView(
            slivers: [
              const CupertinoSliverNavigationBar(
                automaticallyImplyLeading: false,
                largeTitle: Text('My Account'),
              ),
              accountSliverList
            ],
          ),
        );
      }),
    );
  }

  Widget _profilePicture(String profilePicture) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(150),
      child: Image.network(
        profilePicture,
        width: 12.h,
        height: 24.w,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _fullName(String fullName) {
    return Text(
      fullName,
      style: TextStyle(
          fontSize: 14.sp, fontWeight: FontWeight.w600, letterSpacing: .5),
    );
  }

  Widget _emailAddress(String emailAddress) {
    return Text(
      emailAddress,
      style: TextStyle(
          fontSize: 11.sp, fontWeight: FontWeight.w300, letterSpacing: .3),
    );
  }

  Widget _pages() {
    return Card(
      child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: ListTile.divideTiles(context: context, tiles: [
            _pageItem(Icons.volunteer_activism_rounded, 'My Donations',
                Colors.blue, const MyDonations()),
            _pageItem(Icons.account_box_rounded, 'Profile', Colors.green,
                const Profile()),
            _pageItem(Icons.question_answer_rounded,
                'Frequently Asked Questions', Colors.red, const MyDonations())
          ]).toList()),
    );
  }

  Widget _pageItem(IconData icon, String title, Color color, Widget page) {
    return ListTile(
      onTap: (() => Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => page),
          ))),
      horizontalTitleGap: 0,
      leading: Icon(
        icon,
        color: color,
        size: 20.sp,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 12.sp,
        ),
      ),
      trailing: GestureDetector(
        onTap: () {},
        child: Icon(
          Icons.navigate_next_rounded,
          size: 16.sp,
          color: Colors.grey[400],
        ),
      ),
    );
  }

  Widget _logout() {
    return Card(
      child: ListTile(
          onTap: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Signin())),
          title: Text(
            'Sign out',
            style: TextStyle(
                color: Colors.red,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          )),
    );
  }
}
