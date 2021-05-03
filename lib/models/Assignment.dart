class Assignment implements Comparable {
  static const String table = "assignments";

  String id;
  String title;
  DateTime date;
  String priority;

  Assignment({this.id, this.title, this.date, this.priority});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'priority': priority,
    };
  }

  Assignment.fromMap(Map snapshot, String id)
      : id = id ?? '',
        title = snapshot['title'],
        date = DateTime.parse(snapshot['date']),
        priority = snapshot['priority'];

  @override
  int compareTo(other) {
    int val1, val2;
    if (this.priority == "Low")
      val1 = 1;
    else if (this.priority == "Medium")
      val1 = 2;
    else
      val1 = 3;
    if (other.priority == "Low")
      val2 = 1;
    else if (other.priority == "Medium")
      val2 = 2;
    else
      val2 = 3;
    return val2.compareTo(val1);
  }
}
