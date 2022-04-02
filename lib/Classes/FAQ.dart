class FAQ {
  final String question;
  final String answer;
  final String lastUpdated;

  FAQ(
      {required this.question,
      required this.answer,
      required this.lastUpdated});

  factory FAQ.fromJSON(Map<String, dynamic> data) {
    return FAQ(
        question: data['question'],
        answer: data['answer'],
        lastUpdated: data['lastUpdated']);
  }
}
