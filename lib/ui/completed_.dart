import 'package:flutter/material.dart';

class Completed extends StatefulWidget {
  @override
  CompletedState createState() => new CompletedState();
}

class CompletedState extends State<Completed> {
  Map<String, bool> values = {
    'foo': true,
    'bar': false,
  };

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Navigator.pushNamed(context, "/goAddItem");
            },
            // onPressed: _airDress,
          ),
        ],
      ),
      body: new ListView(
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