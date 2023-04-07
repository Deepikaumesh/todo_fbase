// // import 'dart:async';
// // import 'dart:ui';
//
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:kanjirod_com/Main_Screen/Main_Screen.dart';
// import 'package:kanjirod_com/User_Authentication/SignIn_Page.dart';
//
// import 'package:kanjirod_com/User_Authentication/Home_Page_AA.dart';
//
//
//
//
//
// class Splashscreen extends StatefulWidget {
//   _SplashscreenState createState() => _SplashscreenState();
// }
//
// class _SplashscreenState extends State<Splashscreen> {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   User? user;
//
//   void initState() {
//     // TODO: implement initState
//     user = FirebaseAuth.instance.currentUser;
//     checkCustomerLogedIn();
//
//
//     super.initState();
//   }
//
//   // @override
//   // void didChangeDependencies(){
//   //   super.didChangeDependencies();
//   // }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//
//
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "welcome",
//             style: GoogleFonts.aclonica(
//               color: Colors.red.shade900,
//               fontSize: 11.0,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//
//
//       ),
//     );
//   }
//   Future gotoLogin_Customer() async {
//     await Future.delayed(Duration(seconds: 1));
//     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Sign_In_page()));
//   }
//
//
//
//   Future<void> checkCustomerLogedIn() async{
//
//     if(user == null){
//       gotoLogin_Customer();
//     }
//     else{
//       Navigator.push(context, MaterialPageRoute(builder: (context)=>Sign_In_page()));
//     }
//
//   }
//
//
// }