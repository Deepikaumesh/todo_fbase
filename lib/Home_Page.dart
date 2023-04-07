import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  _Home_PageState createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  final CollectionReference _reference = FirebaseFirestore.instance.collection("todo");

  @override
  void initState() {
    // TODO: implement initState
     title = TextEditingController();
    description = TextEditingController();
    super.initState();
  }

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

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
                              builder: (Buildcontext) => Home_Page()));
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
                              builder: (Buildcontext) => Home_Page()));
                    },
                    child: Text("Update"))
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Create(),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
          stream: _reference.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return Card(
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
    );
  }
}
