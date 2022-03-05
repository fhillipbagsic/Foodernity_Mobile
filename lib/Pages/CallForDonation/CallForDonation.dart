import 'package:flutter/material.dart';

class CallForDonation extends StatefulWidget {
  const CallForDonation({Key? key}) : super(key: key);

  @override
  State<CallForDonation> createState() => _CallForDonationState();
}

class _CallForDonationState extends State<CallForDonation> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Text('cfd')),
    );
  }
}
