// ignore_for_file: file_names

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = true,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}
