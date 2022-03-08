import 'package:foodernity_mobile/Classes/Donation.dart';

class CallforDonation {
  final String id;
  final String title;
  final String beneficiaries;
  final String remarks;
  final String image;
  //final List<Donation> donations;

  CallforDonation(
      {required this.id,
      required this.title,
      required this.beneficiaries,
      required this.remarks,
      required this.image});

  factory CallforDonation.fromJSON(Map<String, dynamic> data) {
    return CallforDonation(
        id: data['_id'],
        title: data['title'],
        beneficiaries: data['beneficiaries'],
        remarks: data['remarks'],
        image: data['image']);
  }
}
