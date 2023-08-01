import 'package:flutter/material.dart';
import 'package:thanks_life_daily/screen/home_screen.dart';
import 'package:thanks_life_daily/screen/list_screen.dart';
import 'package:thanks_life_daily/screen/more_screen.dart';

import '../const/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    HomeScreen(),
    ListScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: PRIMARY_COLOR,
      fontSize: 12.0,
    );

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 30.0,
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: Colors.black38,
        selectedLabelStyle: textStyle,
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.sticky_note_2), label: '모아보기'),
          BottomNavigationBarItem(icon: Icon(Icons.workspaces_outline), label: '더보기'),
        ],
      ),
      body: _tabs[_currentIndex],
    );
  }
}
