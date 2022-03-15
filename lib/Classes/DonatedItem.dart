class DonatedItem {
  final String fullName;
  final bool hidden;
  final String donationImage;
  final String donationName;
  final String foodCategory;
  final String quantity;

  DonatedItem(
      {required this.fullName,
      required this.hidden,
      required this.donationImage,
      required this.donationName,
      required this.foodCategory,
      required this.quantity});

  factory DonatedItem.fromJSON(Map<String, dynamic> data) {
    return DonatedItem(
        fullName: data['fullName'],
        hidden: data['hidden'],
        donationImage: data['donationImage'],
        donationName: data['donationName'],
        foodCategory: data['donations']['foodCategory'],
        quantity: data['donations']['quantity']);
  }
}
