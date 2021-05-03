import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:organizer/models/Note.dart';
import 'package:organizer/presentation/notes/NotesOperation.dart';
import 'package:organizer/presentation/notes/pages/add_note_screen.dart';
import 'package:organizer/presentation/notes/pages/edit_note_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotesBuild extends StatelessWidget {
  final String uid;

  NotesBuild(this.uid);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotesOperation>(
      create: (BuildContext context) => NotesOperation(uid),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(scaffoldBackgroundColor: Theme.of(context).primaryColor),
        home: NotesHomeScreen(uid),
      ),
    );
  }
}

class NotesHomeScreen extends StatelessWidget {
  final String uid;

  NotesHomeScreen(this.uid);

  var notesCollections = Firestore.instance.collection("notes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNoteScreen()));
        },
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
        foregroundColor: Colors.blueAccent,
      ),
      body: Consumer<NotesOperation>(
        builder: (context, NotesOperation data, child) {
          return ListView.builder(
            itemCount: data.getNotes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditNoteScreen(data.getNotes[index])));
                },
                child: NotesCard(data.getNotes[index]),
              );
            },
          );
        },
      ),
    );
  }
}

class NotesCard extends StatelessWidget {
  final Note note;

  NotesCard(this.note);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(15),
        height: 150,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue[800], Colors.blue[400]]), borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: GoogleFonts.montserrat(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              note.description,
              style: GoogleFonts.montserrat(color: Colors.white, fontSize: 17),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ));
  }
}
