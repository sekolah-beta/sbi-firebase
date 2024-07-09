class BookModel {
  String? title;
  String? author;
  String? id;

  BookModel({
    this.title,
    this.author,
    this.id,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        title: json["title"],
        author: json["author"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "id": id,
      };
}
