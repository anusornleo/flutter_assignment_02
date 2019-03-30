// import 'package:flutter/material.dart';

// class AddItemScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return AddItemState();
//   }
// }

// class AddItemState extends State<AddItemScreen> {
//   final TextEditingController _newItem = new TextEditingController();
//   final _itemAdd = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("New Subject"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(18),
//         child: Form(
//           key: _itemAdd,
//           child: Column(
//             children: <Widget>[
//               TextFormField(
//               decoration: InputDecoration(
//                 labelText: "Subject",
//               ),
//               validator: (value) {
//                 if (value.isEmpty) {
//                   return "Please fill subject";
//                 }
//               },
//             ),
//             RaisedButton(
//               child: Text("save"),
//               onPressed: () {
//                 if (_itemAdd.currentState.validate()){
//                   Navigator.pushNamed(context, "/");
//                 }

//               },
//             )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_assignment_02/model/todo.dart';

class NoteScreen extends StatefulWidget {
  final Note note;
  NoteScreen(this.note);

  @override
  State<StatefulWidget> createState() => new _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  DatabaseHelper db = new DatabaseHelper();
  final _itemAdd = GlobalKey<FormState>();
  TextEditingController _titleController;

  @override
  void initState() {
    super.initState();

    _titleController = new TextEditingController(text: widget.note.title);
    // _descriptionController = new TextEditingController(text: widget.note.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Note')),
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
                              .saveNote(Note.getValue(_titleController.text))
                              .then((_) {
                            Navigator.pop(context, 'save');
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
      // body: Container(
      //   key: _itemAdd,
      //   margin: EdgeInsets.all(15.0),
      //   alignment: Alignment.center,
      //   child: Column(
      //     children: <Widget>[
      //       TextField(
      //         controller: _titleController,
      //         decoration: InputDecoration(labelText: 'Title'),
      //       ),

      //       Padding(padding: new EdgeInsets.all(5.0)),
      //       RaisedButton(
      //         child: Text('Add'),
      //         onPressed: () async {
      //             db.saveNote(Note.getValue(_titleController.text)).then((_) {
      //               Navigator.pop(context, 'save');
      //             });
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
