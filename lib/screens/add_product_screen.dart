import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  bool imagesPicked = false;
  List<File>? images =[];


  selectImagesToDisplay() async {

    List<XFile> xFiles = await ImagePicker().pickMultiImage();

    if( xFiles.isEmpty) return;

    for( var xFile in xFiles){

      images?.add( File(xFile.path));
    }

    imagesPicked = true;
    setState(() {

    });
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
                TextField(
                  decoration: InputDecoration(
                      hintText: 'Title', border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                      hintText: 'Description', border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Price', border: OutlineInputBorder()),
                ),

                const SizedBox(
                  height: 16,
                ),

                ElevatedButton.icon(onPressed: (){
                  selectImagesToDisplay();
                },
                  icon: const Icon(Icons.photo),
                  label: const Text('Attach Images'),),

                const SizedBox(height: 16,),

                imagesPicked ?
                    SizedBox(height: 300, child: GridView.builder(
                        itemCount: images?.length,

                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ), itemBuilder: (context, index){
                          return Image.file(images![index]);
                    }),)

                    : const SizedBox.shrink(),

                const SizedBox(height: 16,),
                ElevatedButton.icon(onPressed: (){
                },
                  icon: const Icon(Icons.photo),
                  label: const Text('Post Information'),),

              ],
            ),
          ),
        ));
  }
}
