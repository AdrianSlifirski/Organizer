import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organizer/models/FirestoreDB.dart';
import 'package:organizer/models/Note.dart';

class NotesOperation extends ChangeNotifier {
  //List<Map<String, dynamic>> _notes = new List<Map<String, dynamic>>();
  List<Note> _data = new List<Note>();
  FirestoreDB _db = new FirestoreDB();
  String uid;

  List<Note> get getNotes {
    if (_data == null) _data = new List<Note>();
    return _data;
  }

  NotesOperation(String uid) {
    this.uid = uid;
    //DB.init().then((value) => _fetchNotes());
    _fetchNotes();
  }

  void addNewNote(String title, String description) async {
    Note item = Note(title: title, description: description);

    //await DB.insertNote(Note.table, item);
    await _db.addNote(item, uid);
    _fetchNotes();
  }

  void deleteNote(Note note) async {
    //await DB.deleteNote(Note.table, note);
    await _db.deleteNote(note, uid);
    _fetchNotes();
  }

  void updateNote(Note note) async {
    //await DB.updateNote(Note.table, note);
    await _db.updateNote(note, uid);
    _fetchNotes();
  }

  void _fetchNotes() async {
    //_notes = await DB.query(Note.table);
    _data = await _db.getNotes(uid);
    //_data = _notes.map((item) => Note.fromMap(item)).toList();
    notifyListeners();
  }
}
