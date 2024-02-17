import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  CollectionReference categoriesRef =
      FirebaseFirestore.instance.collection('categories');

  bool imagesPicked = false;
  List<File>? images = [];

  String selectedCategory = 'Mobile';

  late TextEditingController titleC, descC, priceC;

  @override
  initState() {
    titleC = TextEditingController();
    descC = TextEditingController();
    priceC = TextEditingController();
    super.initState();
  }

  @override
  dispose() {
    titleC.dispose();
    descC.dispose();
    priceC.dispose();
    super.dispose();
  }

  selectImagesToDisplay() async {
    List<XFile> xFiles = await ImagePicker().pickMultiImage();

    if (xFiles.isEmpty) return;

    for (var xFile in xFiles) {
      images?.add(File(xFile.path));
    }

    imagesPicked = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Show Dropdown

                StreamBuilder<QuerySnapshot>(
                    stream: categoriesRef.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var listOfCategories = snapshot.data!.docs;

                        return DropdownButton<String>(
                            isExpanded: true,
                            value: selectedCategory,
                            items: listOfCategories.map((category) {
                              return DropdownMenuItem<String>(
                                  value: category['title'],
                                  child: Text(category['title']));
                            }).toList(),
                            onChanged: (selectedValue) {
                              setState(() {
                                selectedCategory = selectedValue!;
                              });
                            });
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),

                TextField(
                  controller: titleC,
                  decoration: const InputDecoration(
                      hintText: 'Title', border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: descC,
                  maxLines: 4,
                  decoration: const InputDecoration(
                      hintText: 'Description', border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: priceC,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Price', border: OutlineInputBorder()),
                ),

                const SizedBox(
                  height: 16,
                ),

                ElevatedButton.icon(
                  onPressed: () {
                    selectImagesToDisplay();
                  },
                  icon: const Icon(Icons.photo),
                  label: const Text('Attach Images'),
                ),

                const SizedBox(
                  height: 16,
                ),

                imagesPicked
                    ? SizedBox(
                        height: 300,
                        child: GridView.builder(
                            itemCount: images?.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              return Image.file(images![index]);
                            }),
                      )
                    : const SizedBox.shrink(),

                const SizedBox(
                  height: 16,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    String title = titleC.text.trim();
                    String desc = descC.text.trim();
                    String price = priceC.text.trim();

                    DocumentReference advertisementRef = FirebaseFirestore
                        .instance
                        .collection('advertisements')
                        .doc();

                    // Todo: Also store user information
                    advertisementRef.set({
                      'advertisementId': advertisementRef.id,
                      'title': title,
                      'desc': desc,
                      'price': price,
                      'category': selectedCategory,
                      'postedOn': DateTime.now().millisecondsSinceEpoch,
                      'postedBy': FirebaseAuth.instance.currentUser!.uid,
                    });
                  },
                  icon: const Icon(Icons.arrow_upward),
                  label: const Text('Upload'),
                ),
              ],
            ),
          ),
        ));
  }
}
