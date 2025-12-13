import 'package:flutter/material.dart';
import 'package:sqlite_database/data_show_screen.dart';
import 'package:sqlite_database/db_handler.dart';
import 'package:sqlite_database/model_class.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final nameController = TextEditingController();
  final ageController = TextEditingController();

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

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Enter Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2
                        ),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 2
                        )
                      )

                    ),
                  ),
                  SizedBox(height: 16,),
                  TextField(
                    controller: ageController,
                    decoration: InputDecoration(
                        hintText: "Enter Age",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2
                          ),
                        ),

                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.redAccent,
                                width: 2
                            )
                        )

                    ),
                  ),
                ],
              ),
            ),


            SizedBox(height: 20,),

            ElevatedButton(
              onPressed: () async {
                await DBHandler().insertData(ModelClass(
                    name: nameController.text,
                    age: int.parse(ageController.text),
                ),
                );

                final data = await DBHandler().readData();
                print(data);
                nameController.clear();
                ageController.clear();
              },
              child: Text("Insert"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final data = await DBHandler().readData();
                print(data[3].age);
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
      
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => DataShowScreen()));
        },
        child: Icon(Icons.skip_next, color: Colors.black,),
      ),
    );
    
    
  }
}
