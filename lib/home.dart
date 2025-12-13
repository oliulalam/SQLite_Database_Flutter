import 'package:flutter/material.dart';
import 'package:sqlite_database/db_handler.dart';
import 'package:sqlite_database/model_class.dart';

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
                await DBHandler().insertData(ModelClass(id: 2, name: "Asaduzzaman Asad", age: 34));

                final data = await DBHandler().readData();
                print(data);
              },
              child: Text("Insert"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final data = await DBHandler().readData();
                print(data[0].name);
              },
              child: Text("Read Data"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await DBHandler().deletedData(1);
                print("Deleted Success");
              },
              child: Text("Deleted Data"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final data = await DBHandler().updateData(
                  ModelClass(id: 1, name: "Pokat Fahim", age: 24)
                );
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
