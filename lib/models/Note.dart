class Note {
  static const String table = "notes";

  String id;
  String title;
  String description;

  Note({this.id, this.title, this.description});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(id: json['id'], title: json['title'], description: json['description']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  Note.fromMap(Map snapshot, String id)
      : id = id ?? '',
        title = snapshot['title'],
        description = snapshot['description'];

  toJson() {
    return {
      "title": title,
      "description": description,
    };
  }
}
