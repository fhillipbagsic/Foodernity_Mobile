// ignore_for_file: file_names

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    required this.subtitleValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  String subtitleValue;
  bool isExpanded;
}
