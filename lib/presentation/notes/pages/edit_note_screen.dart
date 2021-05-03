import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:organizer/models/Note.dart';
import 'package:organizer/presentation/notes/NotesOperation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditNoteScreen extends StatelessWidget {
  Note note;

  EditNoteScreen(this.note);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    //margin: EdgeInsets.only(top: 40),
                    padding: EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.height,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.blue[800], Colors.blue[400]]),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: TextField(
                        controller: TextEditingController()..text = note.title,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: GoogleFonts.montserrat(decoration: TextDecoration.none, color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        onChanged: (value) {
                          note.title = value;
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(15),
                    width: 400,
                    height: MediaQuery.of(context).size.height - 350,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.blue[800], Colors.blue[400]]),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: TextEditingController()..text = note.description,
                            maxLines: null,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            style: GoogleFonts.montserrat(decoration: TextDecoration.none, color: Colors.white, fontSize: 18),
                            onChanged: (value) {
                              note.description = value;
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _NoteButton('Save', () {
                    Provider.of<NotesOperation>(context, listen: false).updateNote(note);
                    Navigator.pop(context);
                  }),
                  _NoteButton('Discard', () {
                    Navigator.pop(context);
                  }),
                  _NoteButton('Delete', () {
                    Provider.of<NotesOperation>(context, listen: false).deleteNote(note);
                    Navigator.pop(context);
                  }),
                ],
              )
            ],
          )),
        ));
  }
}

class _NoteButton extends StatelessWidget {
  final String _text;
  final Function _onPressed;

  _NoteButton(this._text, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _onPressed,
      child: Text(_text),
      color: Colors.blueAccent,
      minWidth: 100,
      height: 45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      textColor: Colors.white,
    );
  }
}
