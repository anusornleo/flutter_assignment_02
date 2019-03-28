import 'package:flutter/material.dart';
import 'package:flutter_assignment_02/model/todo.dart';
import 'package:flutter_assignment_02/ui/completed_.dart';
import 'package:flutter_assignment_02/ui/task.dart';
import 'placeholder_widget.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Task(),
    Completed(),
    // PlaceholderWidget(Colors.deepOrange),
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
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

// class TodoScreen extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text('todo'),
//             actions: <Widget>[
//               IconButton(
//                 icon: Icon(Icons.playlist_play),
//                 onPressed: () {
//                   Navigator.pushNamed(context, "/goAddItem");
//                 },
//                 // onPressed: _airDress,
//               ),
//             ],
//           ),

//           bottomNavigationBar: BottomNavigationBar(
//        currentIndex: 0, // this will be set when a new tab is tapped
//        items: [
//          BottomNavigationBarItem(
//            icon: new Icon(Icons.home),
//            title: new Text('Home'),
//          ),
//          BottomNavigationBarItem(
//            icon: new Icon(Icons.mail),
//            title: new Text('Messages'),
//          ),
//        ],
//      ),
//         ));
//   }
// }
