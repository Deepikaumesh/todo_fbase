import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Home_Page_AA.dart';
import 'model/user_model.dart';


class Sign_Up_page extends StatefulWidget {
  const Sign_Up_page({Key? key}) : super(key: key);

  @override
  _Sign_Up_pageState createState() => _Sign_Up_pageState();
}

class _Sign_Up_pageState extends State<Sign_Up_page> {
  var loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController loginemail = TextEditingController();
  TextEditingController loginpassword = TextEditingController();
  TextEditingController resetemail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            TextField(
              controller:username,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: email,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: password,
            ),
            InkWell(
              onTap: () async {
                signUp();
              },
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  alignment: Alignment.center,
                  height: 52,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade400,
                      borderRadius: BorderRadius.circular(12)),
                  child: loading == true
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text("Sign Up"),
                ),
              ),

            ElevatedButton(onPressed: () {
            //  Get.to(Sign_In_page());
            }, child: Text("Sign in")),
            SizedBox(
              height: 20,
            ),

            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
  signUp() async {
    try {
      loading = true;
      await auth.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      await addUser();
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_Page_a()));
      loading= false;
      await verifyEmail();
    } catch (e) {
      SnackBar(
        content: Text("Error$e"),

      );
    }
  }
  addUser() async {
    UserModel user = UserModel(
      username: username.text,
      email: auth.currentUser?.email,
    ); //creating user model instance
    await db
        .collection("user")
        .doc(auth.currentUser?.uid)
        .collection("profile")
        .add(user.toMap());
  }

  SignOut() async {
    await auth.signOut();
  }

  SignIN() async {
    try {
      loading= true;

      await auth.signInWithEmailAndPassword(
          email: loginemail.text, password: loginpassword.text);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_Page_a()));
      loading = false;
    } catch (e) {
      SnackBar(
        content: Text("Error$e"),

      );
      loading= false;
    }
  }

  verifyEmail() async {
    await auth.currentUser?.sendEmailVerification();
    SnackBar(
      content: Text("Email$e"),

    );
  }

}
