import 'package:foodernity_mobile/Classes/DonatedItem.dart';

class AppAnnouncement {
  final String title;
  final String beneficiaries;
  final String remarks;
  final String documentation;
  final String date;
  final List<DonatedItem> itemsDonated;

  AppAnnouncement(
      {required this.title,
      required this.beneficiaries,
      required this.remarks,
      required this.documentation,
      required this.date,
      required this.itemsDonated});

  factory AppAnnouncement.fromJSON(Map<String, dynamic> data) {
    return AppAnnouncement(
        title: data['title'],
        beneficiaries: data['beneficiaries'],
        remarks: data['remarks'],
        documentation: data['documentation'],
        date: data['date'],
        itemsDonated: iterateItemsDonated(data['itemsDonated']));
  }

  static List<DonatedItem> iterateItemsDonated(data) {
    List<DonatedItem> items = [];
    for (var item in data) {
      items.add(DonatedItem.fromJSON(item));
    }
    return items;
  }
}
