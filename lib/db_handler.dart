import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHandler{
  Database? _database;

  Future<Database?> get database async{

    if(_database != null){
      return _database;
    }

    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'mydatabase.db');

    _database = await openDatabase(path, version: 1, onCreate: (db, version){
      db.execute(
        '''
        CREATE  TABLE DatabaseTable (
        id INTEGER PRIMARY KEY,
        name TEXT,
        age INTEGER,
        )
        '''
      );
    },);
    return _database;
  }

  insertData() async{
    Database? db = await database;

    db!.insert('DatabaseTable', {
      'id': '1',
      'name': 'Oliul Alam',
      'age': '25',
    });
  }

  readData() async{
    Database? db = await database;
    db!.query('DatabaseTable');
  }

}