import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Classes/Donation.dart';
import 'package:foodernity_mobile/Pages/Account/DonationDetail.dart';
import 'package:sizer/sizer.dart';

class DonationItem extends StatefulWidget {
  final Donation donation;
  const DonationItem({Key? key, required this.donation}) : super(key: key);

  @override
  State<DonationItem> createState() => _DonationItemState();
}

class _DonationItemState extends State<DonationItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DonationDetail(
              donation: widget.donation,
            ),
          ),
        );
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _donationImage(widget.donation.donationImage),
              SizedBox(
                width: 4.w,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _donationName(widget.donation.donationName),
                    SizedBox(
                      height: .3.h,
                    ),
                    _status(widget.donation.status),
                    SizedBox(
                      height: .3.h,
                    ),
                    _description(widget.donation.status)
                  ],
                ),
              ),
              _viewDetails()
            ],
          ),
        ),
      ),
    );
  }

  Widget _donationImage(String donationImage) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.network(
        donationImage,
        width: 20.w,
        height: 10.h,
      ),
    );
  }

  Widget _donationName(String donationName) {
    return Text(
      widget.donation.donationName,
      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _status(String status) {
    IconData icon;
    Color color;
    String label = '';
    if (status == 'Pending') {
      icon = Icons.hourglass_full_rounded;
      color = Colors.orange;
      label = 'Pending Donation';
    } else if (status == 'Accepted') {
      icon = Icons.check_circle_rounded;
      color = Colors.green;
      label = 'Donation Accepted';
    } else if (status == 'Received') {
      icon = Icons.inventory;
      color = Colors.blue;

      label = 'Donation Received';
    } else if (status == 'Donated') {
      icon = Icons.volunteer_activism_rounded;
      color = Colors.brown;
      label = 'Donated';
    } else {
      icon = Icons.cancel_rounded;
      color = Colors.red;
      label = 'Donation Declined';
    }

    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 11.sp,
        ),
        SizedBox(
          width: .4.w,
        ),
        Text(
          label,
          style: TextStyle(
              fontSize: 11.sp, color: color, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget _description(String status) {
    String description = '';

    if (status == 'Pending') {
      description = 'Please wait for your donation to be accepted.';
    } else if (status == 'Accepted') {
      description = 'Donation Accepted';
    } else if (status == 'Received') {
      description = 'Donation Received';
    } else if (status == 'Donated') {
      description = 'Donation Received';
    } else {
      description = 'Donation declined';
    }
    return SizedBox(
      child: Text(
        description,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _viewDetails() {
    return Icon(
      Icons.navigate_next_rounded,
      color: Colors.grey[400],
      size: 12.sp,
    );
  }
}
