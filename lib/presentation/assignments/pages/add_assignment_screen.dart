import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../AssignmentsOperation.dart';
import 'package:timezone/timezone.dart' as tz;

class AddAssignmentScreen extends StatefulWidget {
  final String uid;
  AddAssignmentScreen(this.uid);
  @override
  AddAssignmentScreenState createState() => AddAssignmentScreenState(uid);
}

class AddAssignmentScreenState extends State<AddAssignmentScreen> {
  final String uid;
  AddAssignmentScreenState(this.uid);
  String _title;
  String _priority;
  DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
  final List<String> _priorities = ['Low', 'Medium', 'High'];

  _handleDatePicker() async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }

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
                        validator: (input) => input.trim().isEmpty ? 'Please enter a task title' : null,
                        onSaved: (input) => _title = input,
                        initialValue: _title,
                        onChanged: (input) => _title = input,
                      ),
                    ),
                  ),
                  Container(
                    height: 30.0,
                  ),
                  Container(
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
                        readOnly: true,
                        controller: _dateController,
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                        onTap: _handleDatePicker,
                        decoration: InputDecoration(
                          labelText: 'Date',
                          labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 30.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    height: 90,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.blue[800], Colors.blue[400]]),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: new Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: Colors.blueAccent,
                        ),
                        child: DropdownButtonFormField(
                          isDense: true,
                          icon: Icon(Icons.arrow_drop_down_circle),
                          iconSize: 22.0,
                          iconEnabledColor: Theme.of(context).primaryColor,
                          items: _priorities.map((String priority) {
                            return DropdownMenuItem(
                              value: priority,
                              child: Text(
                                priority,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            );
                          }).toList(),
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Priority',
                            labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          ),
                          validator: (input) => _priority == null ? 'Please select a priority level' : null,
                          onSaved: (input) => _priority = input,
                          onChanged: (value) {
                            setState(() {
                              _priority = value;
                            });
                          },
                          value: _priority,
                        ),
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
                  if (_title != null && _date != null && _priority != null) {
                    Provider.of<AssignmentsOperation>(context, listen: false).addNewTask(_title, _date, _priority, uid);
                    var rand = new Random();
                    scheduleAlarm(_title, DateFormat('EEEE').format(_date), rand.nextInt(50000));
                  }
                  Navigator.pop(context);
                },
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Text('Add new assignment', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              )
            ],
          )),
        ));
  }

  void scheduleAlarm(String title, String day, int id) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        'Today is the deadline of $title list',
        'Come and see what you have to do',
        _nextInstanceOfMondayTenAM(day),
        const NotificationDetails(
            android: AndroidNotificationDetails('full screen channel id', 'full screen channel name', 'full screen channel description',
                priority: Priority.high, importance: Importance.high, fullScreenIntent: true)),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfMondayTenAM(String day) {
    tz.TZDateTime scheduledDate = _nextInstanceOfTenAM();
    var dateTimeDay = DateTime.monday;
    if (day == "Monday")
      dateTimeDay = DateTime.monday;
    else if (day == "Tuesday")
      dateTimeDay = DateTime.tuesday;
    else if (day == "Wednesday")
      dateTimeDay = DateTime.wednesday;
    else if (day == "Thursday")
      dateTimeDay = DateTime.thursday;
    else if (day == "Friday")
      dateTimeDay = DateTime.friday;
    else if (day == "Saturday")
      dateTimeDay = DateTime.saturday;
    else if (day == "Sunday") dateTimeDay = DateTime.sunday;

    while (scheduledDate.weekday != dateTimeDay) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
