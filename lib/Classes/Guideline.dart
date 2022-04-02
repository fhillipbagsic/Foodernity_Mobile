class Guideline {
  final String guideline;
  final String description;
  final String lastUpdated;

  Guideline(
      {required this.guideline,
      required this.description,
      required this.lastUpdated});

  factory Guideline.fromJSON(Map<String, dynamic> data) {
    return Guideline(
        guideline: data['guideline'],
        description: data['description'],
        lastUpdated: data['lastUpdated']);
  }
}
