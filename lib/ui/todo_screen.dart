import 'package:flutter/material.dart';
import 'package:flutter_assignment_02/model/todo.dart';

class TodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('todo'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.playlist_play),
                onPressed: () {
                  Navigator.pushNamed(context, "/goAddItem");
                },
                // onPressed: _airDress,
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0, // this will be set when a new tab is tapped
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.mail),
                title: new Text('Messages'),
              ),
            ],
          ),
        ));
  }
}
