class Donation {
  final String donationImage;
  final String donationName;
  final List donations;
  final String status;

  Donation(
      {required this.donationImage,
      required this.donationName,
      required this.donations,
      required this.status});

  factory Donation.fromJSON(Map<String, dynamic> data) {
    return Donation(
        donationImage: data['donationImage'],
        donationName: data['donationName'],
        donations: data['donations'],
        status: data['status']);
  }
}
