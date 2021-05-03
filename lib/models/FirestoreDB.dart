import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:organizer/models/Assignment.dart';
import 'package:organizer/models/Note.dart';
import 'package:organizer/models/Task.dart';
import 'package:organizer/models/calendar_model.dart';

class FirestoreDB extends ChangeNotifier {
  final CollectionReference _usersCollectionReference = Firestore.instance.collection('users');

  Future getNotes(String uid) async {
    try {
      var notesDocumentSnapshot = await _usersCollectionReference.document(uid).collection('notes').getDocuments();
      if (notesDocumentSnapshot.documents.isNotEmpty) {
        return notesDocumentSnapshot.documents.map((snapshot) => Note.fromMap(snapshot.data, snapshot.documentID)).where((mappedItem) => mappedItem.title != null).toList();
      }
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Future addNote(Note note, String uid) async {
    try {
      await _usersCollectionReference.document(uid).collection('notes').add(note.toMap());
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Future deleteNote(Note note, String uid) async {
    await _usersCollectionReference.document(uid).collection('notes').document(note.id).delete();
  }

  Future updateNote(Note note, String uid) async {
    try {
      await _usersCollectionReference.document(uid).collection('notes').document(note.id).updateData(note.toMap());
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Future getCalendar(String uid) async {
    try {
      var notesDocumentSnapshot = await _usersCollectionReference.document(uid).collection('callendar').getDocuments();
      if (notesDocumentSnapshot.documents.isNotEmpty) {
        return notesDocumentSnapshot.documents.map((snapshot) => CalendarItem.fromMap(snapshot.data, snapshot.documentID)).toList();
      }
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Future addCalendar(CalendarItem event, String uid) async {
    try {
      await _usersCollectionReference.document(uid).collection('callendar').add(event.toMap());
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Future deleteCalendar(CalendarItem event, String uid) async {
    await _usersCollectionReference.document(uid).collection('callendar').document(event.id).delete();
  }

  Future getAssignments(String uid) async {
    try {
      var assignmentsDocumentSnapshot = await _usersCollectionReference.document(uid).collection('assignments').getDocuments();
      if (assignmentsDocumentSnapshot.documents.isNotEmpty) {
        return assignmentsDocumentSnapshot.documents.map((snapshot) => Assignment.fromMap(snapshot.data, snapshot.documentID)).toList();
      }
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Future addAsignment(Assignment assignment, String uid) async {
    try {
      await _usersCollectionReference.document(uid).collection('assignments').add(assignment.toMap());
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Future deleteAssignment(Assignment assignment, String uid) async {
    await _usersCollectionReference.document(uid).collection('assignments').document(assignment.id).delete();
  }

  Future getTasks(String assignmentID, String uid) async {
    try {
      var tasksDocumentSnapshot = await _usersCollectionReference.document(uid).collection('assignments').document(assignmentID).collection('tasks').getDocuments();
      if (tasksDocumentSnapshot.documents.isNotEmpty) {
        return tasksDocumentSnapshot.documents.map((snapshot) => Task.fromMap(snapshot.data, snapshot.documentID)).toList();
      }
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Future addTask(String assignmentID, Task task, String uid) async {
    try {
      await _usersCollectionReference.document(uid).collection('assignments').document(assignmentID).collection('tasks').add(task.toMap());
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Future updateTask(String assignmentID, Task task, String uid) async {
    try {
      await _usersCollectionReference.document(uid).collection('assignments').document(assignmentID).collection('tasks').document(task.id).updateData(task.toMap());
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }
}
