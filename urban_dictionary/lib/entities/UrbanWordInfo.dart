class UrbanWordInfo {
  String word;
  String description;
  String example;
  String author;

  UrbanWordInfo(this.word, this.description, this.example, this.author);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UrbanWordInfo &&
          runtimeType == other.runtimeType &&
          word == other.word &&
          description == other.description &&
          example == other.example &&
          author == other.author;

  @override
  int get hashCode =>
      word.hashCode ^ description.hashCode ^ example.hashCode ^ author.hashCode;

  @override
  String toString() {
    return 'UrbanWordInfo{word: $word, description: $description, example: $example, author: $author}';
  }
}
