import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/pages/login_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/my_textfield.dart';
import '../pages/Add_Data.dart';
import 'dart:io';
import 'package:flutter_appavailability/flutter_appavailability.dart';

class Home_Page_a extends StatefulWidget {
  const Home_Page_a({Key? key}) : super(key: key);

  @override
  _Home_Page_aState createState() => _Home_Page_aState();
}

class _Home_Page_aState extends State<Home_Page_a> {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection("todo");

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    title = TextEditingController();
    description = TextEditingController();
    super.initState();
  }

  Future<void> Delete(String id) async {
    await _reference.doc(id).delete();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blueGrey,
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (Buildcontext) => Add_Data()));
          }

          //Create(),

          ),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[300],
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              auth.currentUser!.email!,
              style: TextStyle(color: Colors.blueGrey, fontSize: 15),
            ),
            Row(
              children: [
                Text(
                    auth.currentUser!.emailVerified
                        ? "Email verified"
                        : "Email not verified",
                    style:
                        TextStyle(color: Colors.green.shade900, fontSize: 15)),
                auth.currentUser!.emailVerified
                    ? SizedBox(
                        height: 1,
                      )
                    : TextButton(
                        onPressed: () {
                          openEmailApp(context);

                          final snackBar = SnackBar(
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.only(
                              top: 40,
                                bottom: MediaQuery.of(context).size.height - 400,
                                right: 40,
                                left: 40),

                              duration: const Duration(minutes: 1),
                            content: const Text("Please Relogin to continue"),
                            action: SnackBarAction(
                              label: 'Ok',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        },
                        child: Text("verify now!"),
                      ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await auth.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route<dynamic> route) => false);
              },
              icon: Icon(
                Icons.exit_to_app_sharp,
                color: Colors.red.shade900,
              )),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: StreamBuilder(
          stream: _reference.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(documentSnapshot['title']),
                          subtitle:
                              Text(documentSnapshot['description'].toString()),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      _Update(documentSnapshot);
                                    },
                                    icon: Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      Delete(documentSnapshot.id);
                                    },
                                    icon: Icon(Icons.delete)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Future<void> _Update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      title.text = documentSnapshot['title'];
      description.text = documentSnapshot['description'].toString();
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 300,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: Column(
              children: [
                MyTextField(
                  controller: title,
                  hintText: 'title',
                  obscureText: false,
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
                  onTap: () async {
                    await _reference.doc(documentSnapshot!.id).update(
                        {'title': title.text, 'description': description.text});
                    title.clear();
                    description.clear();
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
                        "Update",
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
          );
        });
  }

  void openEmailApp(BuildContext context){
    try{
      AppAvailability.launchApp(Platform.isIOS ? "message://" :         "com.google.android.gm").then((_) {
        print("App Email launched!");
      }).catchError((err) {
        final snackBar = SnackBar(
          content: const Text("Error"),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print(err);
      });
    } catch(e) {
      final snackBar = SnackBar(
        content: const Text("Error"),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
