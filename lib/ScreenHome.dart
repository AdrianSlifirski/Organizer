import 'package:flutter/material.dart';
import 'package:organizer/presentation/tabs/pages/tabs_page.dart';
import 'package:provider/provider.dart';
import 'models/theme.dart';

class ScreenHome extends StatelessWidget {
  final String uid;

  ScreenHome({Key key, @required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: Consumer<ThemeNotifier>(builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.isDarkTheme ? dark : light,
            home: TabsPage(uid: uid),
            debugShowCheckedModeBanner: false,
          );
        }));
  }
}
