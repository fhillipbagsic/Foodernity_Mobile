class AppNotifications {
  String status;
  String message;

  AppNotifications({required this.status, required this.message});

  factory AppNotifications.fromJSON(Map<String, dynamic> data) {
    return AppNotifications(status: data['status'], message: data['message']);
  }
}
