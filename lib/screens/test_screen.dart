import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  String selectedCategory = 'Mobile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              child: StreamBuilder<QuerySnapshot>(
                stream: categories.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List listOfCategories = snapshot!.data!.docs
                        .map((e) => e.data() as Map<String, dynamic>?)
                        .toList();

                    return DropdownButton<String>(
                        value: selectedCategory,
                        items: listOfCategories.map((e) {
                          return DropdownMenuItem<String>(
                              value: e['title'], child: Text(e['title']));
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedCategory = newValue!;
                          });
                        });
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            )
            // DropdownButtonFormField(items:  categories.snapshots().length, onChanged: (newValue){
            //
            // }),
          ],
        ),
      ),
    );
  }
}
