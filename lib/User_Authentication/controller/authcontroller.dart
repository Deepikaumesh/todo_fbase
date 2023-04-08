
//
// import 'dart:js';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../Home_Page_AA.dart';
// import '../SignIn_Page.dart';
// import '../SignUp_Page.dart';
// import '../model/user_model.dart';


// class Authcontroller extends StatelessWidget {
//   //step1.create instance
//
//   FirebaseAuth auth = FirebaseAuth.instance;
//   FirebaseFirestore db = FirebaseFirestore.instance;
//   TextEditingController username = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();
//   TextEditingController loginemail = TextEditingController();
//   TextEditingController loginpassword = TextEditingController();
//   TextEditingController resetemail = TextEditingController();
//   var loading = false;
//
//   //step2.create function
//   //create Account with email and password
//
//   signUp() async {
//     try {
//       loading = true;
//       await auth.createUserWithEmailAndPassword(
//           email: email.text, password: password.text);
//       await addUser();
//       Navigator.push(context, route)
//       //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Sign_Up_page()));
//       // Get.to(() => Home_Page_a());
//       loading.value = false;
//       await verifyEmail();
//     } catch (e) {
//       Get.snackbar("error", "$e");
//     }
//   }
//
//   //add user to database
//   addUser() async {
//     UserModel user = UserModel(
//       username: username.text,
//       email: auth.currentUser?.email,
//     ); //creating user model instance
//     await db
//         .collection("user")
//         .doc(auth.currentUser?.uid)
//         .collection("profile")
//         .add(user.toMap());
//   }
//
//   SignOut() async {
//     await auth.signOut();
//   }
//
//   SignIN() async {
//     try {
//       loading.value = true;
//
//       await auth.signInWithEmailAndPassword(
//           email: loginemail.text, password: loginpassword.text);
//       Get.to(() => Home_Page_a());
//       loading.value = false;
//     } catch (e) {
//       Get.snackbar("error", "$e");
//       loading.value = false;
//     }
//   }
//
//   verifyEmail() async {
//     await auth.currentUser?.sendEmailVerification();
//     Get.snackbar("email", "send");
//   }
//
//
//   resetPassword() async {
//     try {
//       loading.value = true;
//       await auth.sendPasswordResetEmail(email: resetemail.text);
//       Get.snackbar("email", "send successfully");
//       Get.to(() => Sign_In_page());
//       loading.value = false;
//     } catch (e) {
//       Get.snackbar("error", "$e");
//     }
//   }
// }
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/pages/login_page.dart';

import '../Home_Page_AA.dart';
import '../model/user_model.dart';


class Authcontroller extends StatefulWidget {
  const Authcontroller({Key? key}) : super(key: key);

  @override
  _AuthcontrollerState createState() => _AuthcontrollerState();
}

class _AuthcontrollerState extends State<Authcontroller> {

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController loginemail = TextEditingController();
  TextEditingController loginpassword = TextEditingController();
  TextEditingController resetemail = TextEditingController();
  var loading = false;


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
    await auth.currentUser?.sendEmailVerification(
    );
    SnackBar(
      content: Text("Email$e"),

    );
  }
//
//
  resetPassword() async {
    try {
      loading= true;
      await auth.sendPasswordResetEmail(email: resetemail.text);
      SnackBar(
        content: Text("Email send successfully"),

      );
      Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
      loading = false;
    } catch (e) {
      SnackBar(
        content: Text("Error$e"),

      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



