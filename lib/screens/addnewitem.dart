

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ee034/model/user.dart';
import 'package:ee034/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';



class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  _AddItem createState() => _AddItem();
}

class _AddItem extends State<AddItem>{

  TextEditingController nameController = TextEditingController();



  final  database = FirebaseDatabase(databaseURL: "https://ee034-f79b9-default-rtdb.asia-southeast1.firebasedatabase.app/").reference();

  @override
  Widget build(BuildContext context){
    // DatabaseReference location = FirebaseDatabase.instance.reference().child("Location 1");
    final location = database.child('Location 1');
    return Scaffold(
      body:Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'name',
            ),
          ),
          

          ElevatedButton(
            child: const Text('Save'),
            onPressed: () async  {
              //await location.set({'Product Name': productController.text});
              final name = database.child('Location 1').child(nameController.text);
              await name.set({'Name':(nameController.text) });
            },
          ),
        ],
      ),
    );
  }
 
}


