import 'package:flutter/material.dart';
import 'package:flutter_assignment_02/model/todo.dart';

class NoteScreen extends StatefulWidget {
  final Todo todo;
  NoteScreen(this.todo);

  @override
  State<StatefulWidget> createState() => new _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  TodoDatabase db = new TodoDatabase();
  final _itemAdd = GlobalKey<FormState>();
  TextEditingController _titleController;

  @override
  void initState() {
    super.initState();

    _titleController = new TextEditingController(text: widget.todo.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Subject')),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _itemAdd,
          child: Column(
            children: <Widget>[
              TextFormField(
                style: new TextStyle(
                  fontSize: 20,
                ),
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Subject",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please fill subject";
                  }
                },
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      child: Text("save"),
                      onPressed: () {
                        if (_itemAdd.currentState.validate()) {
                          db
                              .saveNewTask(Todo.getValue(_titleController.text))
                              .then((_) {
                            Navigator.pop(context);
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
