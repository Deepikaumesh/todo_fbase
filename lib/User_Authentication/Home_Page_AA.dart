import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/Home_Page.dart';
import 'package:todo_firebase/User_Authentication/SignIn_Page.dart';






class Home_Page_a extends StatefulWidget {
  const Home_Page_a({Key? key}) : super(key: key);

  @override
  _Home_Page_aState createState() => _Home_Page_aState();
}

class _Home_Page_aState extends State<Home_Page_a> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home_Page"),
      actions: [
        TextButton(onPressed: ()async{
              await auth.signOut();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  Sign_In_page()), (Route<dynamic> route) => false);

        },
            child: Text("Log Out",style: TextStyle(color: Colors.white,fontSize: 19),)),
        SizedBox(width: 20,),
      ],
      ),
      body: ListView(
        children: [
          auth.currentUser!.emailVerified?SizedBox(height: 1,):
              Text("${auth.currentUser!.email!} not verified"),
          SizedBox(
            height: 150,
          ),

          Text(auth.currentUser!.email!),
          Text(auth.currentUser!.emailVerified ? "email verified" : "email not verified"),



        ],

      )

    );
  }
}
