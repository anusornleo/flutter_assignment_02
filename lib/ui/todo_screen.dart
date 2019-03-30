import 'package:flutter/material.dart';
import 'package:flutter_assignment_02/ui/completed_.dart';
import 'package:flutter_assignment_02/ui/task.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Task(),
    Completed(),
  ];
  void onTab(int index) {
    setState(() {
      _currentIndex = index; // swith index of page
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTab, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Task'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            title: Text('Completed'),
          ),
        ],
      ),
    );
  }
}
