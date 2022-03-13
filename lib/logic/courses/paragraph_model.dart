class Paragraph {
  String title;
  String description;
  List<String>? images;

  Paragraph({
    required this.title,
    required this.description,
    this.images,
  });

  static Paragraph fromJson(dynamic json) {
    return Paragraph(
        title: json['title'],
        description: json['description'],
        images: json['images'].length != 0 ? json['images'] : []);
  }
}
