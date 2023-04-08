import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../User_Authentication/Home_Page_AA.dart';
import '../User_Authentication/model/user_model.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import 'login_page.dart';

class Register_Page extends StatefulWidget {
  Register_Page({super.key});

  @override
  State<Register_Page> createState() => _Register_PageState();
}

class _Register_PageState extends State<Register_Page> {


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
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),

              Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 25,
                ),
              ),

              const SizedBox(height: 25),

              // username textfield
              MyTextField(
                controller: username,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(height: 20),
              MyTextField(
                controller: email,
                hintText: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 20),

              // password textfield
              MyTextField(
                controller: password,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 20),

              // sign in button
              GestureDetector(
                onTap: () {
                  signUp();
                  username.clear();
                  password.clear();
                  email.clear();
                },
                child: Container(
                  padding: const EdgeInsets.all(25),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade600,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child:
                    Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),



                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already Have an account',
                    style: TextStyle(color: Colors.grey[700], fontSize: 17),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  signUp() async {

    try {
      await auth.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      await addUser();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home_Page_a()));

      await verifyEmail();
      
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
      await auth.signInWithEmailAndPassword(
          email: loginemail.text, password: loginpassword.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home_Page_a()));
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

  verifyEmail() async {
    await auth.currentUser?.sendEmailVerification();
    final snackBar = SnackBar(
      content: const Text("Email send"),
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
