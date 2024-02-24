import 'package:ahsan_online_bazar/screens/add_product_screen.dart';
import 'package:ahsan_online_bazar/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductListScreen extends StatefulWidget {
  final Map<String, dynamic> category; // runtime constant
  const ProductListScreen({super.key, required this.category});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  CollectionReference advertisementsRef =
      FirebaseFirestore.instance.collection('advertisements');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (FirebaseAuth.instance.currentUser != null) {
            // Add Product Screen
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const AddProductScreen();
            }));
          } else {
            // Login Screen
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const LoginScreen();
            }));
          }
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(widget.category['title']),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 180,
            child: Image.network(
              widget.category['image'],
            ),
          ),
          const Gap(16),
          StreamBuilder<QuerySnapshot>(
              stream: advertisementsRef.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var listOfAdvertisements = snapshot.data?.docs;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: listOfAdvertisements?.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Column(
                              children: [
                                Text(listOfAdvertisements?[index]['title']),
                              ],
                            ),
                          );
                        }),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              })
        ],
      ),
    );
  }
}
