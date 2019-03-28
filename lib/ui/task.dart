import 'package:flutter/material.dart';
import 'package:flutter_assignment_02/model/todo.dart';

class Task extends StatefulWidget {
  @override
  TaskState createState() => TaskState();
  
}

class TaskState extends State<Task> {
  TodoProvider todo = TodoProvider();
  Map<String, bool> values = {};

  showDataBase() async {
    List data = await todo.getAll();
    data.forEach((c) => values[c.toString()] = false);
    // values[c.toString().split(',')[1]] = false;
    print(values);
    // print(data[0].toString().split(',')[1]);
    print("Result of Get All");
  }

  @override
  Widget build(BuildContext context) {
    todo.open("todo.db");
    showDataBase();
    return new Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
        actions: <Widget>[
          RaisedButton(
            child: Text("Show All Database"),
            onPressed: () async {
              showDataBase();
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, "/goAddItem");
            },
          ),
        ],
      ),
      body: ListView(
        children: values.keys.map((String key) {
          return new CheckboxListTile(
            title: new Text(key),
            value: values[key],
            onChanged: (bool value) {
              setState(() {
                values[key] = value;
              });
            },
          );
        }).toList(),
      ),
    );
    
  }
}

