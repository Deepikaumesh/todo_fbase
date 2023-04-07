import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/User_Authentication/SignUp_Page.dart';
import 'Forgot_Password_Page.dart';
import 'Home_Page_AA.dart';
import 'controller/authcontroller.dart';







class Sign_In_page extends StatefulWidget {
  const Sign_In_page({Key? key}) : super(key: key);

  @override
  _Sign_In_pageState createState() => _Sign_In_pageState();
}

class _Sign_In_pageState extends State<Sign_In_page> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController loginemail = TextEditingController();
  TextEditingController loginpassword = TextEditingController();
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
              controller: loginemail,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
             controller: loginpassword,
            ),
            SizedBox(
              height: 40,
            ),

            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Forgot_Password_page()));
            }, child: Text("forgot password")),



            InkWell(
              onTap: () async {
                SignIN();
              },
              child:Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  alignment: Alignment.center,
                  height: 52,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade400,
                      borderRadius: BorderRadius.circular(12)),
                  child:
                  loading == true
                      ?
                  CircularProgressIndicator(
                          color: Colors.white,
                        )
                      :Text("Sign In"),
                ),
              ),


            SizedBox(
              height: 20,
            ),

            SizedBox(
              height: 30,
            ),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Sign_Up_page()));

            }, child: Text("Sign Up")),
          ],
        ),
      ),
    );
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
}
