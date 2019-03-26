import 'package:flutter/material.dart';

class AddItemScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddItemState();
  }
}

class AddItemState extends State<AddItemScreen> {
  final TextEditingController _newItem = new TextEditingController();
  final _itemAdd = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("New Subject"),
        bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.access_alarms),
                text: "first",
              ),
              Tab(
                icon: Icon(Icons.airline_seat_flat),
                text: "Second",
              ),
              Tab(
                icon: Icon(Icons.airplay),
                text: "thrid",
              )
            ],
          ),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Form(
          key: _itemAdd,
          child: Column(
            children: <Widget>[
              TextFormField(
              decoration: InputDecoration(
                labelText: "Subject",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please fill subject";
                }
              },
            ),
            RaisedButton(
              child: Text("save"),
              onPressed: () {
                if (_itemAdd.currentState.validate()){
                  Navigator.pushNamed(context, "/");
                }
                
              },
            )
            ],
          ),
        ),
      ),
    );
  }
}
