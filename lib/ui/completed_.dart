import 'package:flutter/material.dart';
import 'package:flutter_assignment_02/model/todo.dart';

class Completed extends StatefulWidget {
  @override
  CompletedState createState() => new CompletedState();
}

class CompletedState extends State<Completed> {
  List<Note> items = new List();
  DatabaseHelper db = new DatabaseHelper();
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    db.getAllComplete().then((notes) {
      setState(() {
        notes.forEach((note) {
          items.add(Note.fromMap(note));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (items.length == 0) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Todo'),
            backgroundColor: Colors.blue,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteNote(context),
              ),
            ],
          ),
          body: Center(
            child: new Text(
              "No data found..",
              textAlign: TextAlign.center,
            ),
          ));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Todo'),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteNote(context),
            ),
          ],
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, position) {
                Map i = items[position].toMap();
                return ListTile(
                  title: Text(i['title'],
                      style: DefaultTextStyle.of(context)
                          .style
                          .apply(fontSizeFactor: 1.5)),
                  trailing: Checkbox(
                    value: i['done'] == 0 ? false : true,
                    onChanged: (bool value) {
                      setState(() {
                        db.updateNote(Note.fromMap({
                          'id': i['id'],
                          'title': i['title'],
                          'done': false,
                        }));
                        db.getAllComplete().then((notes) {
                          setState(() {
                            items.clear();
                            notes.forEach((note) {
                              items.add(Note.fromMap(note));
                            });
                          });
                        });
                      });
                    },
                  ),
                );
              }),
        ),
      );
    }
  }

  void _deleteNote(BuildContext context) async {
    db.deleteAllDone();
    db.getAllComplete().then((notes) {
      setState(() {
        items.clear();
        notes.forEach((note) {
          items.add(Note.fromMap(note));
        });
      });
    });
  }
}
