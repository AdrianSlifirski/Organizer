import 'package:flutter/material.dart';
import 'package:organizer/models/FirestoreDB.dart';
import 'package:organizer/models/Task.dart';

class TasksOperation extends ChangeNotifier {
  List<Task> _data = new List<Task>();
  FirestoreDB _db = new FirestoreDB();
  String uid;
  String _id;

  TasksOperation(String id, String uid) {
    this._id = id;
    this.uid = uid;
    _fetchTasks();
  }

  void changeID(String id) async {
    this._id = id;
    _fetchTasks();
  }

  void addNewTask(String title, int done) async {
    Task item = Task(id: _id, title: title, done: done);
    print(_id);
    await _db.addTask(_id, item, uid);
    _fetchTasks();
  }

  void changeTaskState(Task task) async {
    await _db.updateTask(_id, task, uid);
    _fetchTasks();
  }

  void _fetchTasks() async {
    _data = await _db.getTasks(_id, uid);
    notifyListeners();
  }

  List<Task> get getTasks {
    if (_data == null) _data = new List<Task>();
    return _data;
  }
}
