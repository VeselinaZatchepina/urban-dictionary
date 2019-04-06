class WordInfo {
  int id;
  String word;
  String description;
  String example;
  String author;

  WordInfo({this.id, this.word, this.description, this.example, this.author});

  factory WordInfo.fromJson(Map<String, dynamic> json) => new WordInfo(
      id: json["id"],
      word: json["word"],
      description: json["description"],
      example: json["example"],
      author: json["author"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "word": word,
        "description": description,
        "example": example,
        "author": author
      };
}
