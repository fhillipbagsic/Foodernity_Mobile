import 'package:foodernity_mobile/Pages/Account/MyAccount.dart';

class Account {
  final String fullName;
  final String emailAddress;
  final String profilePicture;
  final String method;
  final bool hidden;

  Account(
      {required this.fullName,
      required this.emailAddress,
      required this.profilePicture,
      required this.method,
      required this.hidden});

  factory Account.fromJSON(Map<String, dynamic> data) {
    return Account(
        fullName: data['fullName'],
        emailAddress: data['emailAddress'],
        profilePicture: data['profilePicture'],
        method: data['method'],
        hidden: data['hidden']);
  }
}
