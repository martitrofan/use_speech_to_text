import 'package:flutter/material.dart';
import 'package:speetch_to_text_use/res/res.dart';
import 'package:speetch_to_text_use/screens/one_screen.dart';
import 'package:speetch_to_text_use/screens/two_screen.dart';

///Домашняя (базовая) страница для навигатора между другими окнами
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  List<Widget> pages = [
    OneScreen(),
    TwoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).primaryColorLight,
        onTap: (newIndex) => setState(() => _index = newIndex),
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.brightness_auto_rounded),
            label: AppString.OneScreenName,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_handball_rounded),
            label: AppString.TwoScreenName,
          ),
        ],
      ),
    );
  }
}
