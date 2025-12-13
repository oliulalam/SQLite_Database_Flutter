import 'package:flutter/material.dart';
import 'package:sqlite_database/db_handler.dart';

class DataShowScreen extends StatefulWidget {
  const DataShowScreen({super.key});

  @override
  State<DataShowScreen> createState() => _DataShowScreenState();
}

class _DataShowScreenState extends State<DataShowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Show Data"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: FutureBuilder(
        future: DBHandler().readData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  snapshot.data![index].name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  snapshot.data![index].age.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),

                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    final itemId = snapshot.data![index].id;

                    if (itemId != null) {
                      showDeleteDialog(itemId);
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void showDeleteDialog(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("Delete Data"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () async {
                await DBHandler().deletedData(id);

                Navigator.pop(context);

                setState(() {}); // 🔥 refresh list

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Data Deleted Successfully")),
                );
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

}
