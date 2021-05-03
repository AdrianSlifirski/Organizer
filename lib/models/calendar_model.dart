class CalendarItem {
  static String table = "events";

  String id;
  String name;
  String date;

  CalendarItem({this.id, this.name, this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
    };
  }

  CalendarItem.fromMap(Map snapshot, String id)
      : id = id ?? '',
        name = snapshot['name'],
        date = snapshot['date'];
}
