import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'SignIn_Page.dart';





class Forgot_Password_page extends StatefulWidget {
  const Forgot_Password_page({Key? key}) : super(key: key);

  @override
  _Forgot_Password_pageState createState() => _Forgot_Password_pageState();
}

class _Forgot_Password_pageState extends State<Forgot_Password_page> {
  TextEditingController resetemail = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  var loading = false;

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
              controller:resetemail,
            ),
            SizedBox(
              height: 20,
            ),






            SizedBox(
              height: 30,
            ),

            InkWell(
              onTap: () async {
                resetPassword();
              },
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  alignment: Alignment.center,
                  height: 52,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade400,
                      borderRadius: BorderRadius.circular(12)),
                  child:
                  loading == true ?
                  CircularProgressIndicator(
                    color: Colors.white,
                  )
                      :const Text("Send Reset Link"),
                ),
              ),
          ],
        ),
      ),
    );
  }
  resetPassword() async {
    try {
      loading= true;
      await auth.sendPasswordResetEmail(email: resetemail.text);
      SnackBar(
        content: Text("Email send successfully"),

      );
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Sign_In_page()));
      loading = false;
    } catch (e) {
      SnackBar(
        content: Text("Error$e"),

      );
    }
  }
}
