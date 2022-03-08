import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Classes/CallForDonation.dart';
import 'package:foodernity_mobile/Pages/CallForDonation/CallForDonationDetail.dart';
import 'package:sizer/sizer.dart';

class CallForDonationItem extends StatefulWidget {
  final CallforDonation item;
  const CallForDonationItem({Key? key, required this.item}) : super(key: key);

  @override
  State<CallForDonationItem> createState() => _CallForDonationItemState();
}

class _CallForDonationItemState extends State<CallForDonationItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => CallForDonationDetail(item: widget.item)),
            ),
          )),
      child: Card(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(
                widget.item.image,
                height: 20.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Text(widget.item.title)
          ],
        ),
      ),
    );
  }
}
