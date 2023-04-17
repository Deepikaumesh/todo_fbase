import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/pages/login_page.dart';

import '../components/my_textfield.dart';


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
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              MyTextField(
                controller: resetemail,
                hintText: 'Email',
                obscureText: false,
              ),
              SizedBox(
                height: 29,
              ),
              GestureDetector(
                onTap: () async {
                  resetPassword();
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
                      "Send Reset Link",
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
      ),
    );
  }

  resetPassword() async {
    try {
      loading = true;
      await auth.sendPasswordResetEmail(email: resetemail.text);
      final snackBar = SnackBar(
        content: Text("Email send successfully"),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      loading = false;
    } catch (e) {
      final snackBar = SnackBar(
        content: Text("Error$e"),
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
