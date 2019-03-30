import 'package:flutter/material.dart';
import 'package:flutter_assignment_02/model/todo.dart';

class Completed extends StatefulWidget {
  @override
  CompletedState createState() => new CompletedState();
}

class CompletedState extends State<Completed> {
  List<Todo> items = new List(); // List to Show a data
  TodoDatabase db = new TodoDatabase();

  @override
  void initState() {
    super.initState();
    db.getAllComplete().then((todos) {
      // restart read Data when it changed
      setState(() {
        todos.forEach((note) {
          items.add(Todo.fromMap(note));
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
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteNote(context),
            ),
          ],
        ),
        body: Center(
          child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                    color: Colors.black,
                  ),
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
                        db.updateNote(Todo.fromMap({
                          'id': i['id'],
                          'title': i['title'],
                          'done': false,
                        }));
                        db.getAllComplete().then((todos) {
                          setState(() {
                            items.clear();
                            todos.forEach((note) {
                              items.add(Todo.fromMap(note));
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
    db.getAllComplete().then((todos) {
      // restart read Data when it changed
      setState(() {
        items.clear();
        todos.forEach((note) {
          items.add(Todo.fromMap(note));
        });
      });
    });
  }
}
