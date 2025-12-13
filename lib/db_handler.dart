import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite_database/model_class.dart';

class DBHandler{
  Database? _database;

  Future<Database?> get database async{

    if(_database != null){
      return _database;
    }

    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'mydatabase.db');

    _database = await openDatabase(path, version: 2, onCreate: (db, version){
      db.execute(
        '''
        CREATE TABLE myTable (
        id INTEGER PRIMARY KEY,
        name TEXT,
        age INTEGER
        )
        '''
      );
    },);
    return _database;
  }

  insertData(ModelClass modelClass) async{
    Database? db = await database;

    await db!.insert('myTable', modelClass.toMap() );
  }

  readData() async{
    Database? db = await database;
    final list = await db!.query('myTable');
    return list.map((map) => ModelClass.fromMap(map)).toList();
  }

  deletedData(int id) async{
    Database? db = await database;
    await db!.delete(
        "myTable",
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  updateData(ModelClass modelClass) async{
    Database? db = await database;
    await db!.update(
        "myTable", modelClass.toMap(),
      where: 'id= ?',
      whereArgs: [modelClass.id],
    );
  }

}