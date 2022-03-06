class AppNotifications {
  String type;
  String message;

  AppNotifications({required this.type, required this.message});

  factory AppNotifications.fromJSON(Map<String, dynamic> data) {
    return AppNotifications(type: data['type'], message: data['message']);
  }
}
