import 'package:flutter/material.dart';
import 'package:sqlite_database/db_handler.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.blue[400],
        foregroundColor: Colors.white,
      ),
      
      body: Center(
        child: ElevatedButton(
            onPressed: ()async{
              await DBHandler().insertData(3, 'Asad', 29 );

              final data = await DBHandler().readData();
              print(data);
            },
            child: Text("Insert", )
        ),
      ),
      
    );
  }
}
