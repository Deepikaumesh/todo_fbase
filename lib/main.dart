import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:todo_firebase/pages/login_page.dart';

import 'User_Authentication/Home_Page_AA.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Intro(),
    );
  }
}

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
    user = FirebaseAuth.instance.currentUser;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      showNextButton: true,
      // showBackButton: true,
      showSkipButton: false,
      showDoneButton: true,
      showBottomPart: true,
      done: Text("Done"),
      onDone: () {
        user != null
            ? Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home_Page_a()))
            : Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginPage()));
      },
      next: Icon(Icons.arrow_forward),
      pages: [
        PageViewModel(
            image: Image.asset("assets/images/1.jpg"),
            title: "Todo",
            body:
                "To-do lists offer a way to increase productivity, stopping you from forgetting things, "
                "helps prioritise tasks, manage tasks effectively, use time wisely and improve time management as well as workflow.",
            decoration: const PageDecoration(
              imagePadding: EdgeInsets.only(top: 50),
            )),
        PageViewModel(
            image: Image.asset("assets/images/2.jpg"),
            title: "Easy to use",
            body:
                "To-do lists offer a way to increase productivity, stopping you from forgetting things, "
                "helps prioritise tasks, manage tasks effectively, use time wisely and improve time management as well as workflow.",
            decoration: const PageDecoration(
              imagePadding: EdgeInsets.only(top: 50),
            )),
      ],
    );
  }
}
