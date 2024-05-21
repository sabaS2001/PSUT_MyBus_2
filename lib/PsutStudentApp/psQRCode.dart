import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'psBottomNavBar.dart';
import 'package:qr_flutter/qr_flutter.dart';
class PSQRCode extends StatelessWidget {
  PSQRCode({super.key});

  final CollectionReference users = FirebaseFirestore.instance.collection('students');
  final User? user = FirebaseAuth.instance.currentUser;

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
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30.0,),
                        SizedBox(
                          width: 300,
                          height: 300,
                          child: QrImageView(
                            data: data['firstName'] ?? 'none' + data["lastName"] ?? 'none'  + data['studentID'] ?? 'none'+ data['imageLink'] ?? 'none',
                            size: 300,
                          ),
                        ),
                        const Text('Student Information',
                          style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Wellfleet',
                        ),),
                        Container(
                          width: MediaQuery.sizeOf(context).width - 20,
                          height: MediaQuery.sizeOf(context).height * .15,
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: Colors.blue,
                              width:  2.0,
                              style: BorderStyle.solid,
                            )
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: (MediaQuery.sizeOf(context).width - 20) * .40,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(data['imageLink'] ?? 'none'),
                                  backgroundColor: Colors.blue.shade900,
                                  radius: 50.0,
                                ),
                              ),
                              SizedBox(
                                width: (MediaQuery.sizeOf(context).width - 20) * .50,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('First Name: ${ data['firstName'] ?? 'none'}',
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'Wellfleet',
                                    ),),
                                    Text('Last Name: ${data['lastName'] ?? 'none'}',
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: 'Wellfleet',
                                      ),),
                                    Text('Student ID: ${data['studentID'] ?? 'none'}',
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: 'Wellfleet',
                                      ),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              return  Padding(
                padding: const EdgeInsets.all(40.0),
                child: Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      strokeWidth: 4.0,
                      color: Colors.blue[900],
                    ),
                  ),
                ),
              );
            }
            return  Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    strokeWidth: 4.0,
                    color: Colors.blue[900],
                  ),
                ),
              ),
            );
          }),

    );
  }
}