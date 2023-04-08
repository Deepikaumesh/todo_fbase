import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../User_Authentication/Home_Page_AA.dart';
import '../components/my_textfield.dart';

class Add_Data extends StatefulWidget {
  const Add_Data({Key? key}) : super(key: key);

  @override
  _Add_DataState createState() => _Add_DataState();
}

class _Add_DataState extends State<Add_Data> {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection("todo");

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(
              controller: title, hintText: 'title', obscureText: false,
              // decoration: InputDecoration(labelText: 'title'),
            ),
            SizedBox(
              height: 20,
            ),
            MyTextField(
              controller: description,
              hintText: 'description',
              obscureText: false,
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Create();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (Buildcontext) => Home_Page_a()));
              },
              child: Container(
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade600,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    "Add",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> Create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      title.text = documentSnapshot['title'];
      description.text = documentSnapshot['description'].toString();
    }
    await _reference
        .add({'title': title.text, 'description': description.text});
  }
}
