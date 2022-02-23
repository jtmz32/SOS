

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ee034/model/user.dart';
import 'package:ee034/screens/addnewitem.dart';
import 'package:ee034/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ee034/screens/login_screen.dart';
import 'package:firebase_database/firebase_database.dart';

var lists = [];
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final database = FirebaseDatabase(
      databaseURL: "https://ee034-f79b9-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .reference()
      .child('Location 1');
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      

body: Container(
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: database.onValue,
              builder: (context, AsyncSnapshot<Event> snapshot) {
                if (snapshot.hasData && !snapshot.hasError &&
                    snapshot.data!.snapshot.value != null) {
                  print("Error on the way");
                  lists.clear();
                  DataSnapshot dataValues = snapshot.data!.snapshot;
                  Map<dynamic, dynamic> values = dataValues.value;
                  values.forEach((key, values)  {
                    lists.add(values);
                  });
                  return  ListView.builder(
                    shrinkWrap: true,
                    itemCount: lists.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("tutors: " + lists[index]["tutors"].toString()),
                            
                          ],
                        ),
                      );
                    },
                  );
                }
                return Container(child: Text("Add Tutors"));
              },
            ),
            ElevatedButton(
              child: const Text('Add Tutors'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddItem()),
                );
              },
            ),
          ],

        )
      ),

    );
  }
}
