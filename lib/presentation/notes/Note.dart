class Note {
  static const String table = "notes";

  int id;
  String title;
  String description;

  Note({this.id, this.title, this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    Object _titleid = map['title'];
    return Note(id: map['id'], title: _titleid.toString(), description: map['description']);
  }
}
