// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../User_Authentication/Home_Page_AA.dart';
// import '../components/my_textfield.dart';
//
// class Update_data extends StatefulWidget {
//   var pass_title;
//   var pass_description;
//
//   Update_data({required this.pass_title, required this.pass_description});
//
//   @override
//   _Update_dataState createState() => _Update_dataState();
// }
//
// class _Update_dataState extends State<Update_data> {
//   final CollectionReference _reference =
//       FirebaseFirestore.instance.collection("todo");
//
//   TextEditingController title = TextEditingController();
//   TextEditingController description = TextEditingController();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     title = TextEditingController(text: widget.pass_title);
//     description = TextEditingController(text: widget.pass_description);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: title,
//               // hintText: 'title',
//               // obscureText: false,
//               // decoration: InputDecoration(labelText: 'title'),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             TextField(
//               controller: description,
//               //hintText: 'description',
//               // obscureText: false,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             TextButton(onPressed: (){
//               _Update();
//             }, child: Text("ok"))
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _Update([DocumentSnapshot? documentSnapshot]) async {
//     if (documentSnapshot != null) {
//       title.text = documentSnapshot['title'];
//       description.text = documentSnapshot['description'].toString();
//     }
//     ElevatedButton(
//         onPressed: () async {
//           await _reference
//               .doc(documentSnapshot!.id)
//               .update({'title': title.text, 'description': description.text});
//           title.clear();
//           description.clear();
//           Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                   builder: (Buildcontext) => Home_Page_a()));
//         },
//         child: Text("Update"));
//  }
// }
