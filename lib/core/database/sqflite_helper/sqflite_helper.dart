import 'package:sqflite/sqflite.dart';

import '../../../feature/task/data/model/task_model.dart';

//* Offline Database
class SqfliteHelper {
  late Database db;
  //*1. create DB
  //*2.create table
  //*3.CRUD => create - read - update - delete

  //! Initialization Database
  void intiDB() async {
    //*step 1 => Create database
    print('Database created successfully');
    await openDatabase(
      'tasks.db',
      version: 1,
      onCreate: (Database db, int v) async {
        //*step 2 => create table
        return await db.execute('''
      CREATE TABLE Tasks (
        id INTEGER PRIMARY KEY ,
        title TEXT,
        note TEXT,
        date TEXT,
        startTime TEXT,
        endTime TEXT,
        color INTEGER,
        isCompleted INTEGER )
      ''').then(
          (value) => print('Table created successfully'),
        );
      },
      onOpen: (db) => print('Database opened'),
    ).then((value) => db = value);
  }

  //! Get From Database
  Future<List<Map<String, dynamic>>> getFromDB() async {
    return await db.rawQuery('SELECT * FROM Tasks');
  }

  //! Insertion into Database
  Future<int> insertToDB(TaskModel model) async {
    return await db.rawInsert('''
      INSERT INTO Tasks( 
      title ,note ,date ,startTime ,endTime ,color ,isCompleted )
         VALUES
         ('${model.title}','${model.note}','${model.date}','${model.startTime}',
       '${model.endTime}','${model.color}','${model.isCompleted}')''');
  }

  //! Update Database
  Future<int> updatedDB(int id) async {
    return await db.rawUpdate('''
    UPDATE Tasks
    SET isCompleted = ?
    WHERE id = ?
   ''', [1, id]);
  }

  //! Delete from Database
  Future<int> deleteFromDB(int id) async {
    return await db.rawDelete(
      '''DELETE FROM Tasks WHERE id = ?''',
      [id],
    );
  }
}
