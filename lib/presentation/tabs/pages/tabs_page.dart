import 'package:flutter/material.dart';
import 'package:organizer/models/tab_navigation_item.dart';

class TabsPage extends StatefulWidget {
  final String uid;

  TabsPage({Key key, @required this.uid}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState(uid);
}

class _TabsPageState extends State<TabsPage> {
  final String uid;
  _TabsPageState(this.uid);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<TabNavigationItem> lists = TabNavigationItem.getList(context, uid);

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          for (final tabItem in lists) tabItem.page,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _currentIndex,
        onTap: (int index) => setState(() => _currentIndex = index),
        items: <BottomNavigationBarItem>[
          for (final tabItem in lists)
            BottomNavigationBarItem(
              icon: tabItem.icon,
              title: tabItem.title,
            ),
        ],
      ),
    );
  }
}
