import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'psBottomNavBar.dart';
import 'package:qr_flutter/qr_flutter.dart';
class PSQRCode extends StatelessWidget {
  PSQRCode({super.key});

  CollectionReference users = FirebaseFirestore.instance.collection('students');

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.fromLTRB(0.0, 30.0, 30.0, 0.0),
          child: const Center(
            child: Text(
              'QR Code',
              style: TextStyle(
                fontSize: 22.0,
                fontFamily: 'Wellfleet',
                color: Colors.black,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,

        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PSNavBar()),
              );
            },
            icon: const Icon(Icons.arrow_circle_left_outlined, size: 40.0,),
            color: Colors.blue[900],
          ),
        ),
      ),
      body: FutureBuilder(
          future: users.doc(user?.uid).get(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasData && snapshot.data!.exists){
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                // return Text('First Name: ${data['firstName']}');
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Column(
                    children: [
                      const SizedBox(height: 30.0,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(70.0, 30.0, 40.0, 20.0),
                        child: SizedBox(
                          width: 500,
                          height: 300,
                          child: Center(
                            child: QrImageView(
                              data: data['firstName'] + data['lastName']  + data['studentID'],
                              size: 600,
                            ),
                          ),
                        ),
                      ),
                      const Text('Student Information',
                        style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Wellfleet',
                      ),),
                      Container(
                        width: 320,
                        height: 100,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                            width:  2.0,
                            style: BorderStyle.solid,
                          )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('First Name: ${ data['firstName']}',
                            style: const TextStyle(
                              fontSize: 17.0,
                              fontFamily: 'Wellfleet',
                            ),),
                            Text('Last Name: ${data['lastName']}',
                              style: const TextStyle(
                                fontSize: 17.0,
                                fontFamily: 'Wellfleet',
                              ),),
                            Text('Student ID: ${data['studentID']}',
                              style: const TextStyle(
                                fontSize: 17.0,
                                fontFamily: 'Wellfleet',
                              ),),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
              return  Text('${user?.uid}');
            }
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue[900],
                strokeWidth: 3.0,
              ),
            );
          }),

    );
  }
}