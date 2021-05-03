import 'package:flutter/material.dart';
import 'package:organizer/presentation/notes/NotesOperation.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  AddNoteScreenState createState() => AddNoteScreenState();
}

class AddNoteScreenState extends State<AddNoteScreen> {
  String titleText;
  String descriptionText;

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
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.blue[800], Colors.blue[400]]),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: TextField(
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter title',
                          hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            titleText = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
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
                            maxLines: null,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter some text',
                              hintStyle: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            style: TextStyle(fontSize: 18, color: Colors.white),
                            onChanged: (value) {
                              setState(() {
                                descriptionText = value;
                              });
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
              FlatButton(
                onPressed: () {
                  if (titleText != null && descriptionText != null) {
                    Provider.of<NotesOperation>(context, listen: false).addNewNote(titleText, descriptionText);
                  }
                  Navigator.pop(context);
                },
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Text('Add new note', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              )
            ],
          )),
        ));
  }
}
