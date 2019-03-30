import 'package:flutter/material.dart';
import 'package:flutter_assignment_02/model/todo.dart';
import 'package:flutter_assignment_02/ui/additem_screen.dart';

class Task extends StatefulWidget {
  @override
  TaskState createState() => new TaskState();
}

class TaskState extends State<Task> {
  List<Todo> items = new List(); // List to Show a data
  TodoDatabase db = new TodoDatabase();

  @override
  void initState() {
    super.initState();

    db.getAllTask().then((todos) {
      // restart read data when it changed
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
                icon: Icon(Icons.add),
                onPressed: () => _createNewNote(context),
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
              icon: Icon(Icons.add),
              onPressed: () => _createNewNote(context),
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
                    value: i['done'] == 1 ? false : true,
                    onChanged: (bool value) {
                      setState(() {
                        db.updateNote(Todo.fromMap({
                          'id': i['id'], // old id
                          'title': i['title'], // old title
                          'done': true, // change data as TRUE
                        }));
                        db.getAllTask().then((todos) {
                          // restart read Data when it changed
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

  void _createNewNote(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(Todo.getValue(''))),
    );

    db.getAllTask().then((todos) {
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
