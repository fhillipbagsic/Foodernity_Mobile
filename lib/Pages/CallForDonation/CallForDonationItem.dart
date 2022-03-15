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
                height: 40.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.title,
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.item.remarks,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                        overflow: TextOverflow.ellipsis),
                    maxLines: 2,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
