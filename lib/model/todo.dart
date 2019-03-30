import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableNote = 'noteTable';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDone = 'done';

class Note {
  int _id;
  String _title;
  int _done;

  Note();

  Note.fromMap(Map<String, dynamic> map) {
    print("map['done'].runtimeType");
    print(map['done'].runtimeType);
    this._id = map['id'];
    this._title = map['title'];
    this._done = map['done'] == false ? 0 : 1;
  }

  // Map<String, dynamic> toMap() {

  //   var map = new Map<String, dynamic>();
  //   if (_id != null) {
  //     map['id'] = _id;
  //   }
  //   map['title'] = _title;
  //   map['done'] = _done == true ? 1 : 0;

  //   return map;
  // }
  Map<String, dynamic> toMap() {
    print("_done");
    print(_done.runtimeType);
    Map<String, dynamic> map = {
      columnTitle: _title,
      columnDone: _done
    };

    if (_id != null) {
      map[columnId] = _id;
    }
    return map;
  }

  Note.getValue(title){
    this._title = title;
    this._done = 0;
  }

  Note.map(dynamic obj) {
    this._id = obj['id'];
    this._title = obj['title'];
    this._done = obj['done'];
  }

  int get id => _id;
  String get title => _title;
  // String get description => _done;
  int get done => _done;

}

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes.db');

//    await deleteDatabase(path); // just for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableNote($columnId INTEGER PRIMARY KEY, $columnTitle TEXT, $columnDone TEXT)');
  }

  Future<int> saveNote(Note note) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableNote, note.toMap());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($columnTitle, $columnDescription) VALUES (\'${note.title}\', \'${note.description}\')');

    return result;
  }

  Future<int> saveDone(Note note) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableNote, note.toMap());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($columnTitle, $columnDescription) VALUES (\'${note.title}\', \'${note.description}\')');

    return result;
  }

  Future<List> getAllNotes() async {
    var dbClient = await db;
    // var result = await dbClient.query(tableNote, columns: [columnId, columnTitle, columnDescription]);
    List<Map> result = await dbClient.query(tableNote,
        columns: [columnId, columnTitle, columnDone],
        // where: '$columnDescription = ?', // when des = 0
        where: '$columnDone = ?', // show all
        whereArgs: [0]);
    return result;
  }

  Future<List> getAllComplete() async {
    var dbClient = await db;
    // var result = await dbClient.query(tableNote, columns: [columnId, columnTitle, columnDescription]);
    List<Map> result = await dbClient.query(tableNote,
        columns: [columnId, columnTitle, columnDone],
        // where: '$columnDescription = ?', // when des = 0
        where: '$columnDone = ?', // show all
        whereArgs: [1]);
    // print(result.last);
    return result;
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableNote'));
  }

  Future<Note> getNote(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableNote,
        columns: [columnId, columnTitle, columnDone],
        where: '$columnId = ?',
        whereArgs: [id]);

    if (result.length > 0) {
      return new Note.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteNote(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableNote, where: '$columnId = ?', whereArgs: [id]);
//    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }

  Future<int> deleteAllDone() async {
    var dbClient = await db;
    return await dbClient
        .delete(tableNote, where: '$columnDone = ?', whereArgs: [1]);
//    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }

  Future<int> updateNote(Note note) async {
    var dbClient = await db;
    return await dbClient.update(tableNote, note.toMap(),
        where: "$columnId = ?", whereArgs: [note.id]);
    
//    return await dbClient.rawUpdate(
//        'UPDATE $tableNote SET $columnTitle = \'${note.title}\', $columnDescription = \'${note.description}\' WHERE $columnId = ${note.id}');
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
