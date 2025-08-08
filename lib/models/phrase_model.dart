class Phrase {
  final int id;
  final String phrase;
  final String author;

  Phrase({required this.id, required this.phrase, required this.author});
  factory Phrase.fromJson(Map<String, dynamic> json) {
    return Phrase(
      id: json['id'] as int,
      phrase: json['phrase'] as String,
      author: json['author'] as String,
    );
  }
}
