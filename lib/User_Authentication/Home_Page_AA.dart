import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/pages/login_page.dart';






class Home_Page_a extends StatefulWidget {
  const Home_Page_a({Key? key}) : super(key: key);

  @override
  _Home_Page_aState createState() => _Home_Page_aState();
}

class _Home_Page_aState extends State<Home_Page_a> {
  final CollectionReference _reference = FirebaseFirestore.instance.collection("todo");



  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    title = TextEditingController();
    description = TextEditingController();
    super.initState();
  }
  Future<void> Delete(String id) async {
    await _reference.doc(id).delete();
  }


  Future<void> Create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      title.text = documentSnapshot['title'];
      description.text = documentSnapshot['description'].toString();
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: Column(
              children: [
                TextField(
                  controller: title,
                  decoration: InputDecoration(labelText: 'title'),
                ),
                TextField(
                  controller: description,
                  decoration: InputDecoration(labelText: 'description'),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await _reference
                          .add({'title': title.text, 'description': description.text});
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (Buildcontext) => Home_Page_a()));
                    },
                    child: Text("Create"))
              ],
            ),
          );
        });
  }

  Future<void> _Update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      title.text = documentSnapshot['title'];
      description.text = documentSnapshot['description'].toString();
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: Column(
              children: [
                TextField(
                  controller: title,
                  decoration: InputDecoration(labelText: 'title'),
                ),
                TextField(
                  controller: description,
                  decoration: InputDecoration(labelText: 'description'),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await _reference
                          .doc(documentSnapshot!.id)
                          .update({'title': title.text, 'description': description.text});
                      title.clear();
                      description.clear();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (Buildcontext) => Home_Page_a()));
                    },
                    child: Text("Update"))
              ],
            ),
          );
        });
  }
  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          onPressed: () => Create(),
          child: Icon(Icons.add),
        ),
        backgroundColor: Colors.grey[300],
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[300],
        elevation: 0,

        title:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(auth.currentUser!.email!,style: TextStyle(color: Colors.blueGrey,fontSize: 15),),
            Row(
              children: [
                Text(auth.currentUser!.emailVerified ? "Email verified" : "Email not verified",style: TextStyle(color: Colors.green.shade900,fontSize: 15)),

                    auth.currentUser!.emailVerified ? SizedBox(height: 1,) :TextButton(onPressed: (){

                    }, child: Text("verify")),

              ],
            ),




          ],
        ),

      actions: [
        IconButton(onPressed: ()async{
          await auth.signOut();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    LoginPage()), (Route<dynamic> route) => false);
        }, icon: Icon(Icons.exit_to_app_sharp,color: Colors.red.shade900,)),
        SizedBox(width: 10,),
      ],
      ),
      body:StreamBuilder(
          stream: _reference.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
                  return
                      Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(documentSnapshot['title']),
                        subtitle: Text(documentSnapshot['description'].toString()),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    _Update(documentSnapshot);
                                  },
                                  icon: Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    Delete(documentSnapshot.id);
                                  },
                                  icon: Icon(Icons.delete)),
                            ],
                          ),
                        ),
                      ),

                  );
                });

            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),

      // ListView(
      //   children: [
      //     auth.currentUser!.emailVerified?SizedBox(height: 1,):
      //         Padding(
      //             padding: EdgeInsets.symmetric(horizontal: 70,vertical: 10),
      //             child: Text("${auth.currentUser!.email!} not verified!!",style: TextStyle(color: Colors.red.shade900),)),
      //     SizedBox(
      //       height: 150,
      //     ),
      //
      //
      //
      //
      //
      //   ],
      //
      // )

    );
  }
}
