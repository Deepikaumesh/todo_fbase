import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:todo_firebase/User_Authentication/SignUp_Page.dart';

import 'Home_Page.dart';
import 'User_Authentication/SignIn_Page.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  void initState() {
    // // TODO: implement initState
    // user = FirebaseAuth.instance.currentUser;


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      showNextButton: true,
      // showBackButton: true,
      showSkipButton: false,
      showDoneButton:true ,
      showBottomPart: true,
      done: Text("Done"),
      onDone: (){
        user != null ?

        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_Page())):
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Sign_In_page()));



      },
      next: Icon(Icons.arrow_forward),
      pages: [
        PageViewModel(
          image: Image.asset("assets/images/1.jpg"),
          title: "Todo",
          body: "To-do lists offer a way to increase productivity, stopping you from forgetting things, "
      "helps prioritise tasks, manage tasks effectively, use time wisely and improve time management as well as workflow.",
        decoration: const PageDecoration(
          imagePadding: EdgeInsets.only(top: 50),
        )

        ),
        PageViewModel(
            image: Image.asset("assets/images/2.jpg"),
            title: "Easy to use",
            body: "To-do lists offer a way to increase productivity, stopping you from forgetting things, "
                "helps prioritise tasks, manage tasks effectively, use time wisely and improve time management as well as workflow.",
            decoration: const PageDecoration(
              imagePadding: EdgeInsets.only(top: 50),
            )

        ),

      ],
    );
  }
}
