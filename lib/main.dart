import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:todo_firebase/pages/login_page.dart';

import 'pages/Home_Page_AA.dart';
import 'forth_otp/home.dart';
import 'forth_otp/phone.dart';
import 'forth_otp/verify.dart';

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
      initialRoute: 'Intro',
      routes: {
        'phone': (context) => MyPhone(),
        'verify': (context) => MyVerify(),
        'home': (context) => home(),
        'Intro': (context) => Intro(),
        'Home_Page_AA': (context) => Home_Page_a(),
      },
      //   home: Intro(),
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
   var code = "";

  void initState() {
    // // TODO: implement initState
    user = FirebaseAuth.instance.currentUser;
    // code = FirebaseAuth.instance.verifyPhoneNumber(
    //     phoneNumber: '9526843393',
    //     verificationCompleted: verificationCompleted,
    //     verificationFailed: verificationFailed,
    //     codeSent: codeSent,
    //     codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);

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
            : Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      next: Icon(Icons.arrow_forward),

      pages: [
        PageViewModel(
            image: Image.asset("assets/images/1.jpg"),
            title: "Todo",
            decoration:PageDecoration(  imagePadding: EdgeInsets.only(top: 50),),
            bodyWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
              "To-do lists offer a way to increase productivity, stopping you from forgetting things, "
              "helps prioritise tasks, manage tasks effectively, use time wisely and improve time management as well as workflow.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 17,),
              // body:
              //     "To-do lists offer a way to increase productivity, stopping you from forgetting things, "
              //     "helps prioritise tasks, manage tasks effectively, use time wisely and improve time management as well as workflow.",
              // decoration: const PageDecoration(
              //   bodyAlignment: Alignment.topCenter,
              //   imagePadding: EdgeInsets.only(top: 50),

              ),
            )),
        PageViewModel(
            image: Image.asset("assets/images/2.jpg"),
            title: "Easy to use",
    decoration:PageDecoration(  imagePadding: EdgeInsets.only(top: 50),),
    bodyWidget: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Text(
    "To-do lists offer a way to increase productivity, stopping you from forgetting things, "
    "helps prioritise tasks, manage tasks effectively, use time wisely and improve time management as well as workflow.",
    textAlign: TextAlign.justify,
    style: TextStyle(fontSize: 17,),

            // body:
            //     "To-do lists offer a way to increase productivity, stopping you from forgetting things, "
            //     "helps prioritise tasks, manage tasks effectively, use time wisely and improve time management as well as workflow.",
            // decoration: const PageDecoration(
            //   imagePadding: EdgeInsets.only(top: 50),
            )),
        ),
      ],
    );
  }
}
