class Task {
  static const String table = "tasks";

  String id;
  String title;
  int done;

  Task({this.id, this.title, this.done});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'done': done,
    };
  }

  Task.fromMap(Map snapshot, String id)
      : id = id ?? '',
        title = snapshot['title'],
        done = snapshot['done'];
}
