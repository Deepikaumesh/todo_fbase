

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Phone_verification extends StatefulWidget {
  const Phone_verification({Key? key}) : super(key: key);

  @override
  _Phone_verificationState createState() => _Phone_verificationState();
}

class _Phone_verificationState extends State<Phone_verification> {

String ?number;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body:Padding(
        padding: const EdgeInsets.fromLTRB(10, 100,10, 10),
        child: Container(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 20),
              child: Text("Enter Your Phone Number",style: TextStyle(
              color: Colors.green[900],
                fontSize: 20,
                fontWeight: FontWeight.bold,

              ),),
              ),
              TextField(
                obscureText: true,
                onChanged: (val){
                  number = val;
                },
                cursorColor: Colors.green[900],
                style: TextStyle(
                  height: 1
                ),
                decoration: InputDecoration(
                  fillColor: Colors.green[200],
                 filled: true,
                  prefixIcon: Icon(Icons.phone,
                    color: Colors.green[900],
                  ),
                  hintText: "Enter Phone Number",
                  hintStyle: TextStyle(
                    color: Colors.green[900]
                  )
                ),
              ),
              SizedBox(height: 25,),
              
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0,20,0,0),
              //   child: ButtonTheme(
              //     buttonColor: Colors.red,
              //     height: 50,
              //     minWidth: MediaQuery.of(context).size.width,
              //     child: ElevatedButton.icon(
              //       onPressed: () {
              //
              //       },
              //       icon: Icon(Icons.send,color:Colors.white ,),
              //       label:Text("Send Code",style: TextStyle(color: Colors.white),),
              //     ),
              //     splashColor: Colors.green[800],
              //   ),
              // )
              GestureDetector(
                onTap: () {
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (Buildcontext) => Home_Page_a()));
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.green[900],
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child:  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.send,color: Colors.white,),
                        SizedBox(width: 5,),
                        Text(
                          "Send Code",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }
}
