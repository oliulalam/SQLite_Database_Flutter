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

  insertData(int id, String name, int age) async{
    Database? db = await database;
    Map<String, Object> map ={
      'id': id,
      'name': name,
      'age': age,
    };
    await db!.insert('myTable', map );
  }

  readData() async{
    Database? db = await database;
    final list = await db!.query('myTable');
    return list;
  }

}