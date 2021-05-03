import 'dart:io';

import 'package:flutter/material.dart';
import 'package:organizer/presentation/assignments/TasksOperation.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatefulWidget {
  final String _id;

  AddTaskScreen(this._id);

  @override
  AddTasksScreenState createState() => AddTasksScreenState();
}

class AddTasksScreenState extends State<AddTaskScreen> {
  String _title;

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
                    height: 90,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.blue[800], Colors.blue[400]]),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: TextFormField(
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        ),
                        autofocus: false,
                        validator: (value) {
                          if (value.isEmpty) return 'Please enter a task title';
                          return null;
                        },
                        //validator: (input) => input.trim().isEmpty ? 'Please enter a task title' : null,
                        onSaved: (input) => _title = input,
                        initialValue: _title,
                        onChanged: (input) => _title = input,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 30.0,
              ),
              FlatButton(
                onPressed: () {
                  if (_title != null) {
                    Provider.of<TasksOperation>(context, listen: false).addNewTask(_title, 0);
                    sleep(Duration(milliseconds: 300));
                  }
                  Navigator.pop(context);
                },
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Text('Add new task', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              )
            ],
          )),
        ));
  }
}
