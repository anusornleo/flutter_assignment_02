import 'package:flutter/material.dart';
import 'package:flutter_assignment_02/model/todo.dart';
import 'package:flutter_assignment_02/ui/additem_screen.dart';

class ListViewNote extends StatefulWidget {
  @override
  _ListViewNoteState createState() => new _ListViewNoteState();
}

class _ListViewNoteState extends State<ListViewNote> {
  List<Note> items = new List();
  DatabaseHelper db = new DatabaseHelper();
  bool isChecked = false;

  @override
  void initState() {
    super.initState();

    db.getAllNotes().then((notes) {
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
                icon: Icon(Icons.add),
                onPressed: () => _createNewNote(context),
                // onPressed: _airDress,
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
              icon: Icon(Icons.add),
              onPressed: () => _createNewNote(context),
              // onPressed: _airDress,
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
                    value: i['done'] == 1 ? false : true,
                    onChanged: (bool value) {
                      setState(() {
                        db.updateNote(Note.fromMap({
                          'id': i['id'],
                          'title': i['title'],
                          'done': true,
                        }));
                        db.getAllNotes().then((notes) {
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

  // void _deleteNote(BuildContext context, Note note, int position) async {
  //   db.deleteNote(note.id).then((notes) {
  //     setState(() {
  //       items.removeAt(position);
  //     });
  //   });
  // }

  // void _navigateToNote(BuildContext context, Note note) async {
  //   String result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => NoteScreen(note)),
  //   );

  //   if (result == 'update') {
  //     db.getAllNotes().then((notes) {
  //       setState(() {
  //         items.clear();
  //         notes.forEach((note) {
  //           items.add(Note.fromMap(note));
  //         });
  //       });
  //     });
  //   }
  // }

  void _createNewNote(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(Note.getValue(''))),
    );

    if (result == 'save') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Note.fromMap(note));
          });
        });
      });
    }
  }
}
