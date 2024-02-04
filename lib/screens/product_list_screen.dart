import 'package:ahsan_online_bazar/screens/add_product_screen.dart';
import 'package:ahsan_online_bazar/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  final Map<String, dynamic> category; // runtime constant
  const ProductListScreen({super.key, required this.category});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){

       // if( FirebaseAuth.instance.currentUser != null ){
       //   // Add Product Screen
       //   Navigator.of(context).push(MaterialPageRoute(builder: (context){
       //     return const AddProductScreen();
       //   }));
       // }else{
         // Login Screen
         Navigator.of(context).push(MaterialPageRoute(builder: (context){
           return const LoginScreen();
         }));
      // }


      }, child: const Icon(Icons.add),),
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
          )
        ],
      ),
    );
  }
}
