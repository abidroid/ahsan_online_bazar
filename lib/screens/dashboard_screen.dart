import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: categories.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          print(snapshot.toString());
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          if(snapshot.hasData){

            // List<Map<String, dynamic>> listOfCategories =
            //     snapshot.data as List<Map<String, dynamic>>;

            List listOfCategories = snapshot.data?.docs.map((e) => e.data() as Map<String, dynamic>?).toList();

            print('**************************');
            print(listOfCategories.length);

            return ListView.builder(
                itemCount: listOfCategories.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> category = listOfCategories[index];
                  return Card(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.network(category['image']),
                        ),
                      ],
                    ),
                  );
                });
          }

          return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
