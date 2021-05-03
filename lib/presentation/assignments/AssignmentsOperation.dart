import 'package:flutter/material.dart';
import 'package:organizer/models/Assignment.dart';
import 'package:organizer/models/FirestoreDB.dart';

class AssignmentsOperation extends ChangeNotifier {
  List<Assignment> _data = new List<Assignment>();
  FirestoreDB _db = new FirestoreDB();
  String _uid;
  int _currentSort = 1;

  AssignmentsOperation(String uid) {
    this._uid = uid;
    _fetchAssignments();
  }

  void addNewTask(String title, DateTime date, String priority, String uid) async {
    Assignment item = Assignment(title: title, date: date, priority: priority);
    await _db.addAsignment(item, uid);
    _fetchAssignments();
  }

  void deleteAssignment(Assignment assignment) async {
    await _db.deleteAssignment(assignment, _uid);
    _fetchAssignments();
  }

  List<Assignment> get getTasks {
    if (_data == null) _data = new List<Assignment>();
    return _data;
  }

  void _fetchAssignments() async {
    _data = await _db.getAssignments(_uid);
    if (_currentSort == 1)
      _data.sort((taskA, taskB) => taskA.compareTo(taskB));
    else
      _data.sort((taskA, taskB) => taskA.date.compareTo(taskB.date));
    notifyListeners();
  }

  void changeSort() async {
    if (_currentSort == 1) {
      _currentSort = 2;
      _data.sort((taskA, taskB) => taskA.compareTo(taskB));
    } else {
      _currentSort = 1;
      _data.sort((taskA, taskB) => taskA.date.compareTo(taskB.date));
    }
    notifyListeners();
  }

  int getSort() {
    return _currentSort;
  }
}
