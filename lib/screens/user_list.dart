import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  final firebase = FirebaseDatabase.instance;
  final rootName = "Users"; // root or users table
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    retrievedNameFromDB();
  }

  retrievedNameFromDB() async {
    final databaseReference = firebase.ref(rootName);
    final snapshot = await databaseReference.get();
    if (snapshot.exists){
      for (final userData in snapshot.children){
        setState(() {
          users.add(User.fromDataSnapshot(userData));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Users'),
        ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
             return GestureDetector(
               onTap: () {
               },
               child: Padding(
                 padding: const EdgeInsets.all(5),
                 child: Column(
                   children: [
                     Text(
                       users[index].name,
                       textAlign: TextAlign.left,
                       style: const TextStyle(
                         color: Colors.black54,
                         fontSize: 18,
                         fontWeight: FontWeight.w600
                       ),
                     )
                   ],
                 ),
               ),
             );
           }),
    );
  }
}
