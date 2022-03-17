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
            _image(widget.item.image),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title(widget.item.title),
                  const SizedBox(
                    height: 5,
                  ),
                  _remarks(widget.item.remarks)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _image(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Image.network(
        image,
        height: 40.h,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _title(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _remarks(String remarks) {
    return Text(
      remarks,
      style: TextStyle(
          fontSize: 12.sp,
          color: Colors.grey[600],
          overflow: TextOverflow.ellipsis),
      maxLines: 2,
    );
  }
}
