import 'package:flutter/material.dart';
import 'package:organizer/controllers/authentications.dart';
import 'package:organizer/main.dart';
import 'package:organizer/models/theme.dart';
import 'package:organizer/presentation/notes/pages/notes_home_screen.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotesPage extends StatelessWidget {
  final String uid;

  NotesPage({Key key, @required this.uid}) : super(key: key);

  /*static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => NotesPage(uid: this.uid),
      );*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        actions: <Widget>[
          Consumer<ThemeNotifier>(
              builder: (context, notifier, child) => IconButton(
                  icon: notifier.isDarkTheme
                      ? FaIcon(
                          FontAwesomeIcons.moon,
                          size: 20,
                          color: Colors.white,
                        )
                      : Icon(Icons.wb_sunny),
                  onPressed: () => {notifier.toggleTheme()})),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () => signOutUser().then((value) {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (Route<dynamic> route) => false);
            }),
          )
        ],
      ),
      body: Center(
        child: NotesBuild(uid),
      ),
    );
  }
}
