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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await DBHandler().insertData(3, 'Asad', 29);

                final data = await DBHandler().readData();
                print(data);
              },
              child: Text("Insert"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final data = await DBHandler().readData();
                print(data);
              },
              child: Text("Read Data"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await DBHandler().deletedData(2);
                print("Deleted Success");
              },
              child: Text("Deleted Data"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final data = await DBHandler().updateData(1, 'Fahim', 24);
                print('Update Success');
              },
              child: Text("Updated Data"),
            ),
          ],
        ),
      ),
    );
  }
}
