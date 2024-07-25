import 'package:sqflite/sqflite.dart';
import 'package:todoapp/Model/notes_model.dart';
import 'package:todoapp/enum/todo_status.dart';
import 'package:uuid/uuid.dart';

class DatabaseServices {
  final String _databaseName = "todo_application.db";
  final int _databaseVersion = 1;

  final String _tableName = "todo";
  final String _tableId = "_id";
  final String _tableTitle = "title";
  final String _tableDescription = "description";
  final String _tableCompleted = "completed";
  final String _tableCreatedDate = "created_date";

  Database? _instance;

  Future<Database> get _database async {
    final _dbPath = await getDatabasesPath();
    _instance ??= await openDatabase(
      "$_dbPath/$_databaseName",
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE $_tableName($_tableId TEXT PRIMARY KEY, $_tableTitle TEXT,$_tableDescription,  $_tableCompleted INTEGER DEFAULT 0 NOT NULL, $_tableCreatedDate INTEGER)");
      },
    );

    return _instance!;
  }

  Future<Notes> addNotes(
      {required String title, required String description}) async {
    final database = await _database;
    final Map<String, dynamic> data = {
      _tableId: const Uuid().v4(),
      _tableTitle: title,
      _tableDescription: description,
      _tableCreatedDate: DateTime.now().microsecondsSinceEpoch,
    };
    final _ = await database.insert(_tableName, data);

    return Notes(
      id: data[_tableId],
      title: title,
      description: description,
      completed: false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(data[_tableCreatedDate]),
    );
  }

  Future<List<Notes>> getNotes({TodoStatus status = TodoStatus.All}) async {
    final database = await _database;
    final result = await database.query(_tableName,
        where: status != TodoStatus.All ? "$_tableCompleted =?" : null,
        whereArgs: status != TodoStatus.All
            ? [status == TodoStatus.Completed ? 1 : 0]
            : null);
    return result.map((e) => Notes.fromDB(e)).toList();
  }

  Future<void> markedAsCompleted({required String notesId}) async {
    final database = await _database;
    final _ = await database.update(
      _tableName,
      {
        _tableCompleted: 1,
      },
      where: "$_tableId=?",
      whereArgs: [notesId],
    );
  }

  Future<void> deleteNotes({required String notesId}) async {
    final database = await _database;
    final _ = await database.delete(
      _tableName,
      where: "$_tableId=?",
      whereArgs: [notesId],
    );
  }

   Future<void> updatateNotes({required String notesId, required String title, required String description}) async {
    final database = await _database;
    final _ = await database.update(
      _tableName, {
        _tableTitle: title,
        _tableDescription: description
      },
      where: "$_tableId=?",
      whereArgs: [notesId],
    );
  }
}
