// class Note {
//   int _id;
//   String _title;
//   // String _done;
//   bool _done;

//   // Note(this._title, this._done);
//   // Note(this._title);
//   Note();

//   Note.map(dynamic obj) {
//     this._id = obj['id'];
//     this._title = obj['title'];
//     this._done = obj['done'];
//   }

//   int get id => _id;
//   String get title => _title;
//   // String get description => _done;
//   bool get done => _done;

//   Map<String, dynamic> toMap() {
//     var map = new Map<String, dynamic>();
//     if (_id != null) {
//       map['id'] = _id;
//     }
//     map['title'] = _title;
//     map['done'] = _done == true ? 1 : 0;

//     return map;
//   }

//   Note.fromMap(Map<String, dynamic> map) {
//     this._id = map['id'];
//     this._title = map['title'];
//     this._done = map['done'] == 1;
//   }
// }
